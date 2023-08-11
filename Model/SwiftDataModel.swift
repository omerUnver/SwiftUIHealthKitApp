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
    var amount : Int
    
    init(id: UUID = UUID(), date: Date, amount: Int) {
        self.id = id
        self.date = date
        self.amount = amount
        
    }
}

