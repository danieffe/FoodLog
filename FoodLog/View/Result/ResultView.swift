//
//  ResultView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//


import SwiftUI

struct ResultView: View {
    
    @State var selectedFeeling: Feeling?
    @State var selectedSymptoms: [Symptom] = []
    
    var foods: [Food] // The selected Food objects passed from FoodSelectView
    
    // State variable to control the presentation of the summary view
    @State private var showingSummary = false
    
    // Computed property to check if the confirm text can be enabled
    private var canSave: Bool {
        return !selectedSymptoms.isEmpty || selectedFeeling != nil
    }
    
    var body: some View {
        VStack {
            Text("Today's plate:")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
            
            List {
                ForEach(foods, id: \.name) { food in
                    HStack {
                        Text("\(food.emoji) \(food.name)") // Display emoji and food name
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }
                .listRowSeparator(.visible)
            }
            
            // First NavigationLink for feelings
            NavigationLink(destination: FeelingView(selectedFeeling: $selectedFeeling)) {
                VStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                        .shadow(radius: 2, y: -1)
                    HStack {
                        Text("How have you been feeling today?")
                            .foregroundStyle(.black)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "arrowshape.right.circle")
                            .foregroundStyle(.accent)
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, selectedFeeling == nil ? 16 : 0)
                    
                    if let selectedFeeling = selectedFeeling {
                        HStack {
                            Text("\(selectedFeeling.emoji) \(selectedFeeling.name)")
                                .foregroundStyle(.black)
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
            }
            .padding(.top, -8)
            
            // NavigationLink for "odd vibes or symptoms?"
            NavigationLink(destination: ContentView(selectedSymptoms: $selectedSymptoms)) {
                VStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Noticing any odd vibes or symptoms?")
                            .foregroundStyle(.black)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "arrowshape.right.circle")
                            .foregroundStyle(.accent)
                    }
                    .padding(16)
                    
                    if !selectedSymptoms.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(selectedSymptoms, id: \.self) { symptom in
                                    Text("\(symptom.emoji) \(symptom.name)")
                                        .foregroundStyle(.black)
                                        .font(.subheadline)
                                        .padding(.horizontal, 8)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }
                    }

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 16)
            
            // Confirm text
            Button(action: {
                // Show the summary view when the text is tapped
                showingSummary = true
            }) {
                Text("Next")
                    .foregroundColor(canSave ? Color.orange : Color.gray) // Change color based on canSave
                    .font(.headline) // Make the text bold
                    .multilineTextAlignment(.center) // Center align the text
                    .padding(.top, 8) // Reduce spacing above the button
            }
            .disabled(!canSave) // Disable if conditions are not met
            .offset(y: -10) // Move the button up by 10 points
            .sheet(isPresented: $showingSummary) {
                // Present the SummaryView as a modal
                SummaryView(selectedFoods: foods, selectedSymptoms: selectedSymptoms, selectedFeeling: selectedFeeling)
            }
        }
    }
}

#Preview {
    ResultView(foods: [
        Food(name: "Banana", emoji: "🍌", category: "Fruit"),
        Food(name: "Apple", emoji: "🍎", category: "Fruit"),
        Food(name: "Chocolate", emoji: "🍫", category: "Snacks")
    ])
}
