//
//  SwiftDataModel.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 7.08.2023.
//

import Foundation
import SwiftData

@Model
class DailyWaterModel {
    var id = UUID()
    var date : Date
    var amount : Double
    init(id: UUID = UUID(), date: Date, amount: Double) {
        self.id = id
        self.date = date
        self.amount = amount
    }
}
