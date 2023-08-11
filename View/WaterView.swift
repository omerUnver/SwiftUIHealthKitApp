//
//  WaterView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 31.07.2023.
//

import SwiftUI
import SwiftData
struct WaterView: View {
    @State var isAnimating: Bool = false
    @State var counter = 0
    @State var notAnimating : Bool = false
    @State var date : Date = .now
    @State private var showingSheet = false
    
//    UserDefaults
    @AppStorage("su") private var gunlukHedef = 0
    
//    SwiftData
    @Environment(\.modelContext) var context
    @Query(sort: \DailyWaterModel.date, order: .forward) private var waterData : [DailyWaterModel]
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack{
                            Image(systemName: "drop.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            Text("Günlük Su Tüketimi")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 15)
                        var newCounter = waterData.filter({$0.date == date}).reduce(0) {$0 + $1.amount}
                        
                            Text("\(newCounter)/\(gunlukHedef) Bardak")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                                .padding(.bottom, 5)
                        Button(action: {
                            showingSheet.toggle()
                        }, label: {
                           Text("Hedef Belirle")
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                        })
                        .sheet(isPresented: $showingSheet, content: {
                            SheetView(selectHedef: $gunlukHedef)
                                .presentationDetents([.fraction(0.2)])
                        })
                            
                            
                        
                        
                        
                        HStack{
                            Button {
                                if !notAnimating && counter > 0 {
                                    notAnimating = true
                                    counter -= 1
                                    
                                    if let data = waterData.last {
                                        context.delete(data)
                                    }
                                    do {
                                        try context.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                }
                            } label: {
                                Text("-")
                                    .font(.system(size: 20))
                            }
                            
                            
                            
                            Text("\(newCounter)")
                                    .font(.system(size: 26))
                                    .padding(.leading, 8)
                                    .padding(.trailing, 8)
                            
                               
                            
                            
                            
                            
                            Button {
                                if !isAnimating {
                                    isAnimating = true
                                    counter += 1
                                    let water = DailyWaterModel(id: UUID(), date: date, amount: 1)
                                    context.insert(water)
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                            } label: {
                                Text("+")
                                    .font(.system(size: 16.2))
                            }
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.circle)
                        
                        .padding(.leading, 20)
                        .padding(.top, 14)
                        
                    }
                    .padding(.leading, 10)
                    
                    Spacer()
                    HStack{
                        SuTuketimiChartView()
                            .padding(.trailing, 10)
                        if isAnimating {
                            LottieView(name: "ileri.json", isAnimating: $isAnimating)
                                .frame(width: 50, height: 40, alignment: .center)
                                .onDisappear() {
                                    isAnimating = false
                                }
                        }
                        if notAnimating {
                            GeriLottieView(name: "geri.json", notAnimating: $notAnimating)
                                .frame(width: 50, height: 40, alignment: .center)
                                .onDisappear() {
                                    notAnimating = false
                                
                                }
                                
                        }
                    }
                    .padding(.top, 30)
                    .padding(.leading, 8)
                    
                }
                
            }
            
        }
    }
    
    
    
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
