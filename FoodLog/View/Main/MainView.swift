//
//  MainView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 07/10/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        TabView {
            FoodSelectView()
                .tabItem {
                    Label("LogPage", systemImage: "fork.knife")
                }
            
            InsightView(selectedFoods: [], selectedSymptoms: [], selectedFeeling: nil, timestamp: "2024-10-23 15:30") // Provide default values
                .tabItem {
                    Label("Insights", systemImage: "lightbulb.fill")
                }
        }
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    MainView()
        .modelContainer(for: Food.self)
}

