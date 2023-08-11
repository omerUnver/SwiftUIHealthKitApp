//
//  SheetView.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 9.08.2023.
//

import SwiftUI
import SwiftData
struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    let gunlukSuHedefi = [0,5,10,15,20,25,30,35,40,45,50]
    @Binding var selectHedef : Int
    @State var date : Date = .now
    var body: some View {
        VStack{
            Text("Günlük Su Tüketim Hedefinizi Belirleyiniz")
                .foregroundStyle(.blue)
                .font(.system(size: 15))
            Picker("Günlük Hedef", selection: $selectHedef) {
                ForEach(gunlukSuHedefi, id: \.self) { su in
                    Text("\(su)")
                        .task {
                            UserDefaults.standard.set(self.selectHedef, forKey: "su")
                        }
                    
                    
                }
                
                
            }
            .pickerStyle(.palette)
            
            
            Button("Tamam") {
                dismiss()
            }
            .foregroundStyle(.blue)
        }
    }
}

struct StepViewHedef : View {
    @Environment(\.dismiss) var dismiss
    let gunlukAdimHedefleri = [1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000]
    @Binding var selectHedef : Int
    var body: some View {
        VStack{
            Text("Günlük Adım Hedefinizi Belirleyiniz")
                .foregroundStyle(.green)
                .font(.system(size: 15))
            Picker("Günlük Hedef", selection: $selectHedef) {
                ForEach(gunlukAdimHedefleri, id: \.self) { adim in
                    Text("\(adim)")
                        .task {
                            UserDefaults.standard.set(self.selectHedef, forKey: "adim")
                        }
                }
            }
            .pickerStyle(.inline)
            Button("Tamam") {
                dismiss()
            }
            .foregroundStyle(.green)
        }
    }
}

struct CaloriesViewHedef : View {
    @Environment(\.dismiss) var dismiss
    let gunlukCalorieHedefleri = [1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000]
    @Binding var selectHedef : Int
    var body: some View {
        VStack{
            Text("Günlük Kalori Hedefinizi Belirleyiniz")
                .foregroundStyle(.orange)
                .font(.system(size: 15))
            Picker("Günlük Hedef", selection: $selectHedef) {
                ForEach(gunlukCalorieHedefleri, id: \.self) { calorie in
                    Text("\(calorie)")
                        .task {
                            UserDefaults.standard.set(self.selectHedef, forKey: "calorie")
                        }
                }
            }
            .pickerStyle(.inline)
            Button("Tamam") {
                dismiss()
            }
            .foregroundStyle(.orange)
        }
    }
}


