//
//  ResultView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        
        TabView {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            InsightView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .frame(minWidth: 400, minHeight: 300)
    }
}

#Preview {
    ResultView()
}
