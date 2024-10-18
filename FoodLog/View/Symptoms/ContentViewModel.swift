//
//  ContentViewModel.swift
//  FoodLog
//
//  Created by Daniele Fontana on 15/10/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    // Define the list of symptoms
    @Published var symptomsList: [Symptom] = [
        Symptom(emoji: "🌸", name: "Pollen Allergy"),
        Symptom(emoji: "🕸️", name: "Dust Mites"),
        Symptom(emoji: "🐕", name: "Pet Allergies"),
        Symptom(emoji: "🍔", name: "Food Allergies"),
        Symptom(emoji: "🤧", name: "Hay Fever"),
        Symptom(emoji: "😮‍💨", name: "Asthma"),
        Symptom(emoji: "🌿", name: "Eczema"),
        Symptom(emoji: "😨", name: "Hives"),
        Symptom(emoji: "🤕", name: "Sinusitis"),
        Symptom(emoji: "😴", name: "Chronic Fatigue"),
        Symptom(emoji: "🌡️", name: "Fever"),
        Symptom(emoji: "🤒", name: "Sore Throat"),
        Symptom(emoji: "🤢", name: "Nausea"),
        Symptom(emoji: "🤮", name: "Vomiting"),
        Symptom(emoji: "🤒", name: "Cold"),
        Symptom(emoji: "🥵", name: "Heat Intolerance"),
        Symptom(emoji: "💤", name: "Excessive Sleepiness")
    ]
    
    // Track selected symptoms
    @Published var selectedSymptoms: Set<Symptom> = []
    
    // Add new symptom manually
    func addSymptom(_ symptom: Symptom) {
        symptomsList.append(symptom)
    }

    // Toggle symptom selection
    func toggleSymptomSelection(_ symptom: Symptom) {
        if selectedSymptoms.contains(symptom) {
            selectedSymptoms.remove(symptom)
        } else {
            selectedSymptoms.insert(symptom)
        }
    }
}


