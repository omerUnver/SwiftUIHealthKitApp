//
//  ContentView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 31.07.2023.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @StateObject var service = AdimVerileriService()
    @Environment(\.modelContext) private var context
    @State var date : Date = .now
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
                            .frame(height: 180)
                        
                        
                        
                    }
                    .padding()
                }
            }
            
            .scrollIndicators(.hidden)
            .navigationTitle("My Health")
            
        }
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
