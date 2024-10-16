//
//  ResultView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI

struct ResultView: View {
    
    var viewModel: ResultViewModel
    init (text: String) {
        viewModel = .init(text: text)
    }
    var body: some View {
        
        VStack {
            ForEach(viewModel.loadList(), id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }.listRowSeparator(.visible)
        }
    }
}

#Preview {
    ResultView(text: "banana, pineapple, orange, apple, chocolate")
}
