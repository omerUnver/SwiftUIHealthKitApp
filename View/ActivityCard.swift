//
//  HeartRateChartView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 5.08.2023.
//

import SwiftUI
import Charts


struct Activity {
    let id : Int
    let title: String
    let subtitle: String
    let image : String
    let cins : String
    let amount : String
    let color : Color
    let chartsType : chartsType
    let gunlukHedef : gunlukHedef?
    enum chartsType : String {
        case heart = "heart"
        case step = "step"
        case calories = "calories"
        
    }
    enum gunlukHedef : String {
        case step = "step"
        case calories = "calories"
    }
    
    
    
}

struct ActivityCard: View {
    @State var activity : Activity
    @State private var showingStepSheet = false
    @AppStorage("adim") private var gunlukAdimHedef = 0
    @State private var showingCalorieSheet = false
    @AppStorage("calorie") private var gunlukCalorieHedef = 0
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5){
                        HStack{
                            Image(systemName: activity.image)
                                .foregroundColor(activity.color)
                            Text(activity.title)
                                .font(.system(size: 16))
                                .foregroundColor(activity.color)
                        }
                        .padding(.bottom, 4)
                        
                        if activity.gunlukHedef == .none {
                            Text(activity.subtitle)
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                        }
                        if activity.gunlukHedef == .step {
                            
                            Text("\(gunlukAdimHedef) Adım")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                            Button {
                                showingStepSheet.toggle()
                            } label: {
                                Text("Günlük Hedef Belirle")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.green)
                            }
                            .sheet(isPresented: $showingStepSheet) {
                                StepViewHedef(selectHedef: $gunlukAdimHedef)
                                    .presentationDetents([.fraction(0.4)])
                            }
                            
                        }
                        if activity.gunlukHedef == .calories {
                            Text("\(gunlukCalorieHedef) Kcal")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                            Button {
                                showingCalorieSheet.toggle()
                            } label: {
                                Text("Günlük Hedef Belirle")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.orange)
                            }
                            .sheet(isPresented: $showingCalorieSheet) {
                                CaloriesViewHedef(selectHedef: $gunlukCalorieHedef)
                                    .presentationDetents([.fraction(0.4)])
                            }
                            
                        }
                    }
                    Spacer()
                    
                }
                HStack{
                    Text(activity.amount)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.system(size: 26))
                    Text(activity.cins)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Spacer()
                    
                    
                    if activity.chartsType == .heart {
                        HeartChartView()
                        
                        
                    }
                    if activity.chartsType == .step {
                        ChartsView()
                        
                    }
                    if activity.chartsType == .calories {
                        CaloriesChartView()
                        
                    }
                    
                }
                
                
            }
            .padding()
        }
    }
    
}

struct ActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCard( activity: Activity(id: 0, title: " ", subtitle: "", image: "", cins: "", amount: "", color: .green, chartsType: .step, gunlukHedef: .step))
    }
}
