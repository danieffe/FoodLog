//
//  ContentView.swift
//  FoodLog beta
//
//  Created by Daniele Fontana on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    // Define a list of allergies and health problems with corresponding emojis
    let symptomsList = [
        "🌸 Pollen Allergy",
        "🕸️ Dust Mites",
        "🐕 Pet Allergies",
        "🍔 Food Allergies",
        "🤧 Hay Fever",
        "😮‍💨 Asthma",
        "🌿 Eczema",
        "😨 Hives",
        "🤕 Sinusitis",
        "😴 Chronic Fatigue"
    ]
    
    // Track selected items using state
    @State private var selectedSymptoms: Set<String> = []
    
    // Define a fixed grid layout with 3 columns
    let columns = Array(repeating: GridItem(.flexible(minimum: 100, maximum: 120)), count: 3)

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    // Title aligned to the left
                    HStack {
                        Text("How did you feel after eating?")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top) // Add top padding for spacing
                    .padding(16)
                    
                    // Grid-based symptom selection
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) { // Reduced spacing between items to 10
                            ForEach(symptomsList, id: \.self) { symptom in
                                Button(action: {
                                    // Toggle the selected state
                                    if selectedSymptoms.contains(symptom) {
                                        selectedSymptoms.remove(symptom)
                                    } else {
                                        selectedSymptoms.insert(symptom)
                                    }
                                }) {
                                    VStack {
                                        Text(symptom.prefix(2)) // Show only emoji
                                            .font(.largeTitle)
                                            .padding(.bottom, 5)
                                        
                                        Text(String(symptom.dropFirst(2))) // Show text
                                            .font(.footnote)
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding()
                                    .frame(width: 80, height: 80) // Adjusted button size to fit the grid layout
                                    .background(selectedSymptoms.contains(symptom) ? Color.yellow : Color.white)
                                    .cornerRadius(20)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 10) // Adjust horizontal padding if needed
                    }
                    .padding(.bottom, 70)

                    // Detailed View of Selected Symptoms
                    if !selectedSymptoms.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) { // Adjust spacing as needed
                                ForEach(selectedSymptoms.sorted(), id: \.self) { symptom in
                                    Button(action: {
                                        // Toggle the selected state
                                        if selectedSymptoms.contains(symptom) {
                                            selectedSymptoms.remove(symptom)
                                        }
                                    }) {
                                        VStack {
                                            Text(symptom.prefix(2)) // Show only emoji
                                                .font(.title2)
                                            
                                            Text(String(symptom.dropFirst(2))) // Show text
                                                .font(.caption)
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding()
                                        .background(Color.white) // Background color for selected symptoms
                                        .cornerRadius(15)
                                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                    }
                                }
                            }
                            .padding(.horizontal, 20) // Add padding to the scroll view
                        }
                        .frame(height: 60) // Set a height for the detailed view
                        .padding(.bottom, 20) // Spacing from the next elements
                    }

                    Spacer()

                    // "Next" Button without rounded shape
                    Button(action: {
                        print("Next button tapped")
                    }) {
                        Text("Next")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(.orange) // Change text color to match your design
                            .padding() // Add padding for spacing
                            .background(Color.clear) // Use clear background to maintain simple text button style
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .frame(maxWidth: 400)
                }
                .frame(maxWidth: .infinity, alignment: .center)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
