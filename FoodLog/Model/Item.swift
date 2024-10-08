//
//  Item.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
