//
//  AdimSayarApp.swift
//  AdimSayar
//
//  Created by M.Ömer Ünver on 31.07.2023.
//

import SwiftUI

@main
struct AdimSayarApp: App {
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                    .modelContainer(for: [DailyWaterModel.self])
        }
    }
}
