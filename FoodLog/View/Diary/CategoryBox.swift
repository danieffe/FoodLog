//
//  CategoryBox.swift
//  FoodLog
//
//  Created by Daniele Fontana on 16/10/24.
//

import SwiftUI

struct CategoryBox: View {
    let category: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(gradientForCategory(category))
                .frame(height: 150)  // Default height, will change when expanded
            
            Text(category)
                .font(.title)
                .foregroundColor(.white)
                .padding()
        }
    }

    func gradientForCategory(_ category: String) -> LinearGradient {
        switch category {
        case "Vegetables":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .top, endPoint: .bottom)
        case "Fruits":
            return LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .top, endPoint: .bottom)
        case "Meat":
            return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.red]), startPoint: .top, endPoint: .bottom)
        case "Dairy":
            return LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]), startPoint: .top, endPoint: .bottom)
        case "Grains":
            return LinearGradient(gradient: Gradient(colors: [Color.brown, Color.orange]), startPoint: .top, endPoint: .bottom)
        default:
            return LinearGradient(gradient: Gradient(colors: [Color.gray, Color.blue]), startPoint: .top, endPoint: .bottom)
        }
    }
}

