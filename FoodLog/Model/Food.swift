//
//  Food.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 08/10/24.
//

import SwiftData

@Model
class Food {
    var name: String
    var emoji: String
    var category: String

    init(name: String, emoji: String, category: String) {
        self.name = name
        self.emoji = emoji
        self.category = category
    }
}


