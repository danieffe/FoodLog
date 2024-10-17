//
//  MainView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        TabView {
            DiaryView()
                .tabItem {
                    Label("Diary", systemImage: "fork.knife")
                }
            
            ContentView2()
                .tabItem {
                    Label("Insight", systemImage: "lightbulb.fill")
                }
        }
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    MainView()
        .modelContainer(for: Food.self)
}

