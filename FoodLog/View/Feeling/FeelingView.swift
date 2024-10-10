//
//  FeelingView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 08/10/24.
//

import SwiftUI

struct FeelingView: View {
    
    let items = Array(0..<10)
    
    var body: some View {
        VStack {
            Text("How are you feeling today?")
            Text("The feeling tracker allow you to analyse your state of mind.")
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(items, id: \.self) { index in
                        Text("Item \(index)")
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            .rotationEffect(.degrees(Double(index) * 5 - 30))
                            .offset(x: CGFloat(index) * 15 - 10, y: CGFloat(index) * -10)
                            .opacity(1 - Double(index) / Double(items.count))
                    }
                }
                .frame(height: 300)
                .padding()
            }
        }
    }
}

#Preview {
    FeelingView()
}
