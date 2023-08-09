//
//  StepDataModel.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 31.07.2023.
//

import Foundation


struct StepDataModel : Identifiable {
    var id = UUID()
    var date : Date
    var stepCount : Double
    init(id: UUID = UUID(), date: Date, stepCount: Double) {
        self.id = id
        self.date = date
        self.stepCount = stepCount
    }
}

struct BurnedCaloriesData : Identifiable {
    var id = UUID()
    var date : Date
    var burnedCalories : Double
    init(id: UUID = UUID(), date: Date, burnedCalories: Double) {
        self.id = id
        self.date = date
        self.burnedCalories = burnedCalories
    }
}
