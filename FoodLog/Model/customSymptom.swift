//
//  customSymptom.swift
//  FoodLog
//
//  Created by Daniele Fontana on 15/10/24.
//

import Foundation

// Symptom model with an identifiable and hashable structure
struct customSymptom: Identifiable, Hashable {
    let id = UUID()
    let emoji: String
    let name: String
}
