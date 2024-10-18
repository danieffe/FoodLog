//
//  FoodLogApp.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI
import SwiftData

@main
struct FoodApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: Food.self)  // Set up the SwiftData container for the Food model
        }
    }
}
