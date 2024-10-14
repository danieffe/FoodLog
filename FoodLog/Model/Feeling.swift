//
//  Feeling.swift
//  FoodLog
//
//  Created by Daniele Fontana on 14/10/24.
//

// Feeling.swift

import SwiftUI

struct Feeling: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let color: Color
    let emoji: String
}

