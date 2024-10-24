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

    @State private var showingInsightView = false // State to trigger navigation
    @State private var timestamp: String = ""

    var body: some View {
        ScrollView {
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

                Spacer()

                Button(action: {
                    // Get current date and time
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm"
                    timestamp = formatter.string(from: Date())

                    // Show the InsightView
                    showingInsightView = true
                }) {
                    Text("LOG YOUR MEAL")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .font(.headline)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $showingInsightView) {
                    // Present the InsightView
                    InsightView(selectedFoods: selectedFoods, selectedSymptoms: selectedSymptoms, selectedFeeling: selectedFeeling, timestamp: timestamp)
                }
            }
            .padding()
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockFoods = [
            Food(name: "Apple", emoji: "🍎", category: "Fruits"),
            Food(name: "Pizza", emoji: "🍕", category: "Fast Food")
        ]
        let mockSymptoms = [Symptom]() // No symptoms selected
        let mockFeeling = Feeling(name: "Happy", color: .yellow, emoji: "😊")

        return SummaryView(selectedFoods: mockFoods, selectedSymptoms: mockSymptoms, selectedFeeling: mockFeeling)
    }
}
