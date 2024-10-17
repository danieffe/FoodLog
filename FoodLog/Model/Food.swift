//
//  Food.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 08/10/24.
//

import SwiftData
import Foundation

@Model
class Food: Identifiable {
    var id = UUID()
    var name: String
    var emoji: String
    var category: FoodCategory? = FoodCategory.none
    
    init(name: String, emoji: String, category: FoodCategory) {
        self.name = name
        self.emoji = emoji
        self.category = category
    }
    
}

enum FoodCategory: Codable, CaseIterable, Identifiable {
    var id: String { UUID().uuidString }
    case fruit, vegetable, grain, protein, dairy, fatsAndOils, sweetsAndSnacks, none
    
    var name: String {
        get {
            switch self {
            case .fruit: return "Fruit"
            case .vegetable: return "Vegetable"
            case .grain: return "Grain"
            case .protein: return "Protein"
            case .dairy: return "Dairy"
            case .fatsAndOils: return "Fats and Oils"
            case .sweetsAndSnacks: return "Sweets and Snacks"
            case .none: return "No Category"
            }
        }
    }
}
