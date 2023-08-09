//
//  SuTuketimiChartView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 7.08.2023.
//
//
import SwiftUI
import Charts
import SwiftData
struct SuTuketimiChartView: View {
    @Query(sort: \DailyWaterModel.date, order: .forward) private var waterData : [DailyWaterModel]
    @Environment(\.modelContext) private var context
    var body: some View {
        VStack {
            Chart {
                ForEach(waterData, id: \.date) { su in
                    BarMark(x: .value("Time", su.date ..< su.date.advanced(by: 120)),
                            y: .value("Günlük Su Miktarı", su.amount), width: .fixed(10))
                    .foregroundStyle(.blue)
                    
                }
                
            }
            
            .chartScrollableAxes(.horizontal)
            

        }
    }
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
}


#Preview {
    SuTuketimiChartView()
}
