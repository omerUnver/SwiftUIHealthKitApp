//
//  ChartsView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 2.08.2023.
//

import SwiftUI
import Charts
struct DailyStepView : Identifiable {
    let id = UUID()
    let date : Date
    let stepCount : Double
}

struct DailyHeartView : Identifiable {
    let id = UUID()
    let date : Date
    let stepCount : Double
}
struct DailyCaloriesView : Identifiable {
    let id = UUID()
    let date : Date
    let caloriesCount : Double
}

struct ChartsView: View {
    @ObservedObject var service = AdimVerileriService()
    var body: some View {
        VStack{
                Chart {
                    ForEach(service.oneMonthChartsData) { daily in
                        BarMark(x: .value(daily.date.formatted(), daily.date, unit: .day), y: .value("Steps", daily.stepCount))
                            .foregroundStyle(.green)
                    }
                }
                .chartScrollableAxes(.horizontal)
                
                
        }
        
            
            
        }
    }
   
    

//#Preview {
//    ChartsView()
//}
