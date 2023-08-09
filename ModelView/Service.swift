//
//  Service.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 31.07.2023.
//

import Foundation
import HealthKit
class AdimVerileriService: NSObject, ObservableObject{
    let healthStore = HKHealthStore()
    let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    let burnedCalories = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
    let heartRate = HKQuantityType.quantityType(forIdentifier: .heartRate)!
    @Published var activities : [String : Activity] = [:]
    @Published var oneMonthChartsData = [DailyStepView]()
    @Published var oneMonthChartsDataHeart = [DailyHeartView]()
    @Published var oneMontChartCalories = [DailyCaloriesView]()
    
    override init() {
        super.init()
        self.izinAl()
    }
    func izinAl(){
        let heathsType : Set = [stepCountType, burnedCalories, heartRate]
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: heathsType)
                self.AdimOku()
                self.burnedCaloriesToday()
                self.kalpAtisHızı()
                self.fetchOneMonthStepData()
                self.fetchOneMonthHeart()
                self.fetchOneMonthCalories()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
  
    func kalpAtisHızı(){
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: heartRate, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { (query, results, error) in
                if let heartRateSamples = results as? [HKQuantitySample] {
                    if let latestHeartRate = heartRateSamples.first {
                        let heartRateValue = latestHeartRate.quantity.doubleValue(for: HKUnit(from: "count/min"))
                        let activity = Activity(id: 0, title: "Kalp Atış Hızı", subtitle: "En Son", image: "heart.fill", cins: "v/dk", amount: "\(heartRateValue.formattedString())", color: .red, chartsType: .heart)
                        DispatchQueue.main.async {
                            self.activities["avarageHeartRate"] = activity
                            }
                    } else {
                        print("Kalp atış hızı verisi bulunamadı.")
                    }
                } else {
                    print("Veriler alınamadı, hata: \(error?.localizedDescription ?? "Bilinmeyen bir hata oluştu.")")
                }
            }
            healthStore.execute(query)
     
    }
    
    func fetchDailySteps(startDate: Date, completion : @escaping ([DailyStepView]) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let interval = DateComponents(day: 1)
        let query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: nil, anchorDate: startDate, intervalComponents: interval)
        
        query.initialResultsHandler = {query, result, error in
            guard let result = result else {
                completion([])
                return
            }
            var dailySteps = [DailyStepView]()
            result.enumerateStatistics(from: startDate, to: Date()) { statistic, stop in
                dailySteps.append(DailyStepView(date: statistic.startDate, stepCount: statistic.sumQuantity()?.doubleValue(for: .count()) ?? 0.00))
            }
            completion(dailySteps)
            
        }
        healthStore.execute(query)
        
        
        
    }
    func fetchDailyHeartRate(startDate: Date, completion: @escaping ([DailyHeartView]) -> Void) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let interval = DateComponents(day: 1)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples, error in
            guard let samples = samples as? [HKQuantitySample] else {
                completion([])
                return
            }
            
            var dailyHeartRates = [DailyHeartView]()
            let calendar = Calendar.current
            for sample in samples {
                let date = sample.startDate
                let value = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
                
                let dailyStepView = DailyHeartView(date: date, stepCount: value)
                dailyHeartRates.append(dailyStepView)
            }
            
            completion(dailyHeartRates)
        }

        healthStore.execute(query)
    }
   func fetchCaloriesDaily(startDate: Date, completion: @escaping ([DailyCaloriesView]) -> Void) {
       let steps = HKQuantityType(.activeEnergyBurned)
       let interval = DateComponents(day: 1)
       let query = HKStatisticsCollectionQuery(quantityType: steps, quantitySamplePredicate: nil, anchorDate: startDate, intervalComponents: interval)
       
       query.initialResultsHandler = {query, result, error in
           guard let result = result else {
               completion([])
               return
           }
           var dailySteps = [DailyCaloriesView]()
           result.enumerateStatistics(from: startDate, to: Date()) { statistic, stop in
               dailySteps.append(DailyCaloriesView(date: statistic.startDate, caloriesCount: statistic.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0.00))
           }
           completion(dailySteps)
           
       }
       healthStore.execute(query)
       
    }


    
    
    func AdimOku(){
        let calender = Calendar.current
        let date = Date()
        let startOfDay = calender.startOfDay(for: date)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: date, options: .strictStartDate)
           let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
               guard let result = result, let sum = result.sumQuantity() else {
                   print("Adım sayar verileri alınamadı: \(error?.localizedDescription ?? "Bilinmeyen Hata")")
                   return
               }
               
               let totalSteps = sum.doubleValue(for: HKUnit.count())
               print("Bugünkü adım sayısı: \(totalSteps)")
               
               let activities = Activity(id: 1, title: "Günlük Hedef", subtitle: "10.000 Adım", image: "figure.walk", cins: "Adım", amount: "\(totalSteps.formattedString())", color: .green, chartsType: .step)
               
               DispatchQueue.main.async {
                   self.activities["todaySteps"] = activities
               }
           }
           healthStore.execute(query)
    }
    func burnedCaloriesToday(){
        let calender = Calendar.current
        let date = Date()
        let startOfDay = calender.startOfDay(for: date)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: date, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: burnedCalories, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Kalori Verisi Alınamadı \(error?.localizedDescription)")
                return
            }
            let totalCalorie = sum.doubleValue(for: .kilocalorie())
            let activities = Activity(id: 2, title: "Günlük Hedef", subtitle: "1.000 Kcal", image: "flame", cins: "Kcal", amount: "\(totalCalorie.formattedString())", color: .orange, chartsType: .calories)
            DispatchQueue.main.async {
                self.activities["burnedCalories"] = activities
            }
            
            

        }
        healthStore.execute(query)
    }
   

        }
   
extension Date{
    static var startOfDay : Date {
        Calendar.current.startOfDay(for: Date())
    }
    static var startOfWeek : Date {
        let calender = Calendar.current
        var components = calender.dateComponents([.yearForWeekOfYear], from: Date())
        components.weekday = 2
        return calender.date(from: components)!
    }
    
    static var oneMonthAgo : Date {
        let calender = Calendar.current
        let oneMonth = calender.date(byAdding: .month, value: -1, to: Date())
        return calender.startOfDay(for: oneMonth!)
        
    }
    static var oneDayAgo: Date {
        let calender = Calendar.current
        let date = calender.date(byAdding: .day, value: -7, to: Date())!
        return calender.startOfDay(for: date)
        }
    
    
    
    
}



extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
extension AdimVerileriService {
    func fetchOneMonthStepData(){
        fetchDailySteps(startDate: .oneMonthAgo) { dailySteps in
            DispatchQueue.main.async {
                self.oneMonthChartsData = dailySteps
            }
        }
    }
    
    func fetchOneMonthHeart(){
        fetchDailyHeartRate(startDate: .oneDayAgo) { dailyHeart in
            DispatchQueue.main.async {
                self.oneMonthChartsDataHeart = dailyHeart
            }
        }
    }
    
    func fetchOneMonthCalories(){
        fetchCaloriesDaily(startDate: .oneDayAgo) { dailyCalorie in
            DispatchQueue.main.async {
                self.oneMontChartCalories = dailyCalorie
            }
        }
    }
    
    
}
