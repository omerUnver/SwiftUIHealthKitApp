//
//  HeartChartView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 6.08.2023.
//

import SwiftUI
import Charts

struct CaloriesChartView : View {
    @StateObject var service = AdimVerileriService()
    var body: some View {
        VStack {
                    Chart {
                        ForEach(service.oneMontChartCalories) { daily in
                            BarMark(x: .value(daily.date.formatted(),daily.date, unit: .day), y: .value("Calorie", daily.caloriesCount))
                                .foregroundStyle(.orange)
                        }
                    }
                    .chartScrollableAxes(.horizontal)
                    
        
            
        }
        
    }
}


struct HeartChartView: View {
    @StateObject var service = AdimVerileriService()
    var body: some View {
        VStack{
            Chart {
                ForEach(service.oneMonthChartsDataHeart) { daily in
                    BarMark(x: .value("Time", daily.date ..< daily.date.advanced(by: 60)),
                            y: .value("Heart", daily.stepCount), width: .fixed(5))
                        .foregroundStyle(.red)
                }
                
            }
            .chartScrollableAxes(.horizontal)
            
            
        }
        
        
                
    }
    
}
