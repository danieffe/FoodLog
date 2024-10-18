//
//  Untitled.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 15/10/24.
//

import Foundation

class ResultViewModel: ObservableObject {
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    func loadList() -> [String] {
        var list = text.split(separator: ",").map {
            var item = String($0).trimmingCharacters(in: .whitespacesAndNewlines)
            return item.prefix(1).capitalized + item.dropFirst().lowercased()
        }
        list.removeAll { $0.isEmpty }
        return list
    }
}
