//
//  InsightView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI

struct InsightView: View {
    var selectedFoods: [Food]
    var selectedSymptoms: [Symptom]
    var selectedFeeling: Feeling?
    var timestamp: String // To show date and time

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                // Header
                Text("Meals Logged")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                // Timestamp
                Text("Date and Time:")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text(timestamp)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom)

                // Foods Section
                SectionView(title: "You Ate:", items: selectedFoods.map { "\($0.emoji) \($0.name)" })

                // Symptoms Section
                SectionView(title: "You Experienced:", items: selectedSymptoms.isEmpty ? ["No symptom selected."] : selectedSymptoms.map { "\($0.emoji) \($0.name)" })

                // Feelings Section
                if let feeling = selectedFeeling {
                    SectionView(title: "And You Feel:", items: ["\(feeling.emoji) \(feeling.name)"])
                } else {
                    SectionView(title: "Feelings:", items: ["No feeling selected."])
                }

                Spacer()

                // Motivational Quote
                Text("Stay healthy, stay happy!")
                    .font(.footnote)
                    .italic()
                    .foregroundColor(.blue)
                    .padding(.top)
            }
            .padding() // Padding for inner content
            .frame(width: geometry.size.width * 0.95) // Set width relative to screen size
            .background(Color.white) // White background for the main content
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(.bottom, 100) // Extra padding at the bottom to keep it above the tab bar
            .frame(maxWidth: .infinity) // Ensure it expands to the full width
            .background(Color(UIColor.systemGroupedBackground)) // Background outside the white box
        }
        .edgesIgnoringSafeArea(.bottom) // Let the view extend over the tab bar area if needed
    }
}

// Custom SectionView for consistent section styling
struct SectionView: View {
    var title: String
    var items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .bold()
                .foregroundColor(.primary)

            ForEach(items, id: \.self) { item in
                Text("• \(item)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white) // White background for the section
        .cornerRadius(8) // Rounded corners
        .shadow(radius: 5) // Shadow for depth
    }
}

struct InsightView_Previews: PreviewProvider {
    static var previews: some View {
        InsightView(selectedFoods: [Food(name: "Apple", emoji: "🍎", category: "Fruits")],
                    selectedSymptoms: [Symptom(emoji: "🤕", name: "Headache")],
                    selectedFeeling: Feeling(name: "Happy", color: .yellow, emoji: "😊"),
                    timestamp: "2024-10-23 15:30")
    }
}
