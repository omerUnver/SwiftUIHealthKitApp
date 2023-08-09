//
//  ContentView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 31.07.2023.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @ObservedObject var service = AdimVerileriService()
    @Environment(\.modelContext) private var context
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack{
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 1)) {
                        ForEach(service.activities.sorted(by: {$0.value.id < $1.value.id}), id: \.key) {item in
                            ActivityCard(activity: item.value)
                                .foregroundColor(.white)
                            
                        }
                        
                            WaterView()
                                .frame(height: 150)
                        
                        
                        
                    }
                    .padding()
                }
            }
            .onAppear(){
                service.izinAl()
            }
            .scrollIndicators(.hidden)
            .navigationTitle("HealthKit")
            
            }
        }
        
        
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
        
        
        
    }
    
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
