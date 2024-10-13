//
//  SymptomsView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 13/10/24.
//

import SwiftUI

struct ContentView: View {
    // Define the list of symptoms using the Symptom model
    let symptomsList: [Symptom] = [
        Symptom(emoji: "🌸", name: "Pollen Allergy"),
        Symptom(emoji: "🕸️", name: "Dust Mites"),
        Symptom(emoji: "🐕", name: "Pet Allergies"),
        Symptom(emoji: "🍔", name: "Food Allergies"),
        Symptom(emoji: "🤧", name: "Hay Fever"),
        Symptom(emoji: "😮‍💨", name: "Asthma"),
        Symptom(emoji: "🌿", name: "Eczema"),
        Symptom(emoji: "😨", name: "Hives"),
        Symptom(emoji: "🤕", name: "Sinusitis"),
        Symptom(emoji: "😴", name: "Chronic Fatigue")
    ]
    
    // Track selected items using state
    @State private var selectedSymptoms: Set<Symptom> = []
    
    // Track search input
    @State private var searchText: String = ""
    
    // Define a fixed grid layout with 3 columns
    let columns = Array(repeating: GridItem(.flexible(minimum: 90, maximum: 120)), count: 3)

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
                    .padding(.top)
                    .padding(16)

                    // Search bar
                    HStack {
                        TextField("Search symptoms", text: $searchText)
                            .frame(minHeight: 55)
                            .padding(.horizontal, 16)
                            .textFieldStyle(.plain)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: .infinity))
                            .shadow(color: .gray, radius: 1, x: 0, y: 1)
                            .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 20)

                    // Filtered Grid-based symptom selection
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(filteredSymptoms()) { symptom in
                                Button(action: {
                                    // Toggle the selected state
                                    if selectedSymptoms.contains(symptom) {
                                        selectedSymptoms.remove(symptom)
                                    } else {
                                        selectedSymptoms.insert(symptom)
                                    }
                                }) {
                                    VStack {
                                        Text(symptom.emoji) // Show only emoji
                                            .font(.system(size: 40)) // Adjust emoji font size
                                            .padding(.bottom, 3) // Adjusted padding
                                        
                                        Text(symptom.name) // Show text
                                            .font(.system(size: 12)) // Adjust text size
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                    }
                                    .padding()
                                    .frame(width: 100, height: 100)
                                    .background(selectedSymptoms.contains(symptom) ? Color.yellow : Color.white)
                                    .cornerRadius(20)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30)

                    // Detailed View of Selected Symptoms
                    if !selectedSymptoms.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(selectedSymptoms.sorted(by: { $0.name < $1.name })) { symptom in
                                    Button(action: {
                                        // Toggle the selected state
                                        if selectedSymptoms.contains(symptom) {
                                            selectedSymptoms.remove(symptom)
                                        }
                                    }) {
                                        VStack {
                                            Text(symptom.emoji) // Show only emoji
                                                .font(.title2)
                                            
                                            Text(symptom.name) // Show text
                                                .font(.caption)
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .frame(height: 60)
                        .padding(.bottom, 10)
                    }

                    Spacer()

                    // "Next" Button without rounded shape
                    Button(action: {
                        print("Next button tapped")
                    }) {
                        Text("Next")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(.orange)
                            .padding()
                            .background(Color.clear)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .frame(maxWidth: 400)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    // Function to filter symptoms based on search query
    private func filteredSymptoms() -> [Symptom] {
        if searchText.isEmpty {
            return symptomsList
        } else {
            return symptomsList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
