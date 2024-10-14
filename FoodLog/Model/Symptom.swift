//
//  Symptom.swift
//  FoodLog
//
//  Created by Daniele Fontana on 13/10/24.
//

import Foundation

struct Symptom: Identifiable, Hashable {
    var id = UUID()            // Unique identifier for each symptom
    var emoji: String           // The emoji representation of the symptom
    var name: String            // The name or description of the symptom
}
