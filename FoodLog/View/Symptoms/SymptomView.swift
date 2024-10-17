//
//  SymptomView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 15/10/24.
//

import SwiftUI

struct SymptomView: View {
    let symptom: Symptom
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Text(symptom.emoji)
                    .font(.system(size: 40)) // Adjust emoji font size
                    .padding(.bottom, 3) // Space between emoji and text

                // The symptom name text split across two lines for readability
                Text(symptom.name)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2) // Allow the text to take up to 2 lines
                    .fixedSize(horizontal: false, vertical: true) // Enable multiline
                    .frame(maxHeight: 40) // Optional: Set a max height for the text
            }
            .padding()
            .frame(width: 100, height: 100) // Ensure button is consistently sized
            .background(isSelected ? Color.yellow : Color.white)
            .cornerRadius(20)
            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
        }
    }
}

struct SymptomView_Previews: PreviewProvider {
    static var previews: some View {
        // Example symptom for the preview
        SymptomView(symptom: Symptom(emoji: "😴", name: "Chronic Fatigue"), isSelected: false, action: {})
            .previewLayout(.sizeThatFits) // Use a fitting size for the preview
            .padding()
    }
}
