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
    enum chartsType : String {
        case heart = "heart"
        case step = "step"
        case calories = "calories"
        
    }
    
    
    
}

struct ActivityCard: View {
    @State var activity : Activity
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
                        
                        Text(activity.subtitle)
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    
                }
                HStack{
                    Text(activity.amount)

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
        ActivityCard( activity: Activity(id: 0, title: " ", subtitle: "", image: "", cins: "", amount: "", color: .green, chartsType: .step))
    }
}
