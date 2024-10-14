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
    
    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
    }
}
