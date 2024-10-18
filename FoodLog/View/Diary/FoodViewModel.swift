//
//  FoodViewModel.swift
//  FoodLog
//
//  Created by Daniele Fontana on 16/10/24.
//

import Foundation

class FoodViewModel: ObservableObject {
    @Published var foods: [Food] = []

    init() {
        loadFoods()
    }

    func loadFoods() {
        foods = [
            Food(name: "Carrot", emoji: "🥕", category: "Vegetables"),
            Food(name: "Broccoli", emoji: "🥦", category: "Vegetables"),
            Food(name: "Apple", emoji: "🍎", category: "Fruits"),
            Food(name: "Banana", emoji: "🍌", category: "Fruits"),
            Food(name: "Steak", emoji: "🥩", category: "Meat"),
            Food(name: "Chicken", emoji: "🍗", category: "Meat"),
            Food(name: "Milk", emoji: "🥛", category: "Dairy"),
            Food(name: "Cheese", emoji: "🧀", category: "Dairy"),
            Food(name: "Rice", emoji: "🍚", category: "Grains"),
            Food(name: "Bread", emoji: "🍞", category: "Grains")
        ]
    }

    func foodsByCategory() -> [String: [Food]] {
        return Dictionary(grouping: foods, by: { $0.category })
    }
}


