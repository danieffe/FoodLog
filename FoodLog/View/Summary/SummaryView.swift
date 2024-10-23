//
//  SummaryView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 23/10/24.
//

import SwiftUI

struct SummaryView: View {
    var selectedFoods: [Food]
    var selectedSymptoms: [Symptom]
    var selectedFeeling: Feeling?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Summary")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            Text("TODAY YOU ATE:")
                .font(.headline)
            ForEach(selectedFoods) { food in
                Text("• \(food.emoji) \(food.name)")
            }

            Text("THEN YOU EXPERIENCED:")
                .font(.headline)
            // Check if any symptoms are selected
            if selectedSymptoms.isEmpty {
                Text("No symptom selected.")
            } else {
                ForEach(selectedSymptoms) { symptom in
                    Text("• \(symptom.emoji) \(symptom.name)")
                }
            }

            if let feeling = selectedFeeling {
                Text("AND YOU FEEL:")
                    .font(.headline)
                Text("• \(feeling.emoji) \(feeling.name)")
            } else {
                Text("No feeling selected.")
            }

            Spacer() // Pushes the button to the bottom

            // LOG YOUR MEAL button
            Button(action: {
                // Action for logging the meal goes here
                print("Meal logged!")
            }) {
                Text("LOG YOUR MEAL")
                    .frame(maxWidth: .infinity, minHeight: 50) // Full width and minimum height
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .font(.headline)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.bottom, 20) // Add some padding at the bottom
        }
        .padding()
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock data for preview
        let mockFoods = [
            Food(name: "Apple", emoji: "🍎", category: "Fruits"),
            Food(name: "Pizza", emoji: "🍕", category: "Fast Food")
        ]
        let mockSymptoms = [Symptom]() // No symptoms selected
        let mockFeeling = Feeling(name: "Happy", color: .yellow, emoji: "😊")

        return SummaryView(selectedFoods: mockFoods, selectedSymptoms: mockSymptoms, selectedFeeling: mockFeeling)
    }
}
