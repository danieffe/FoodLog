//
//  SymptomsView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 13/10/24.
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
    let columns = Array(repeating: GridItem(.flexible(minimum: 120, maximum: 150)), count: 2)

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
                        LazyVGrid(columns: columns, spacing: 15) { // Increased spacing between items to 15
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
                                            .font(.system(size: 50)) // Increased emoji font size
                                            .padding(.bottom, 5)
                                        
                                        Text(String(symptom.dropFirst(2))) // Show text
                                            .font(.system(size: 16)) // Increased text font size
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2) // Ensures the text stays within two lines
                                    }
                                    .padding()
                                    .frame(width: 120, height: 120) // Adjusted button size to make it larger
                                    .background(selectedSymptoms.contains(symptom) ? Color.yellow : Color.white)
                                    .cornerRadius(25) // Increased corner radius
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 20) // Adjust horizontal padding if needed
                    }
                    .padding(.bottom, 30) // Reduced bottom padding to lessen white space above the button

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
                        .padding(.bottom, 10) // Reduced bottom padding
                    }

                    Spacer() // Pushes the button to the bottom properly

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
                    .padding(.bottom, 20) // Increased bottom padding for the button
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
