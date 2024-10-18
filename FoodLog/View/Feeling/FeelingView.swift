//
//  FeelingView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 08/10/24.
//

import SwiftUI

struct FeelingView: View {
    
    // Ordered feelings from "baddest" to "best"
    let feelings: [Feeling] = [
        Feeling(name: "Angry", color: .red, emoji: "😡"),
        Feeling(name: "Worried", color: .purple, emoji: "😟"),
        Feeling(name: "Sad", color: .blue, emoji: "😢"),
        Feeling(name: "Lonely", color: .indigo, emoji: "🥺"),
        Feeling(name: "Confused", color: .brown, emoji: "🤔"),
        Feeling(name: "Tired", color: .gray, emoji: "😴"),
        Feeling(name: "Surprised", color: .pink, emoji: "😲"),
        Feeling(name: "Calm", color: .green, emoji: "😌"),
        Feeling(name: "Excited", color: .orange, emoji: "🤩"),
        Feeling(name: "Happy", color: .yellow, emoji: "😊")
    ]
    
    @Binding var selectedFeeling: Feeling?
    @Environment(\.presentationMode) var presentationMode
    @State var animationSelectedFeeling: Feeling?
    
    var body: some View {
        VStack {
            // Left-aligned text at the top
            VStack(alignment: .leading) {
                Text("How are you feeling today?")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text("The feeling tracker allows you to analyze your state of mind.")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top, .leading], 20)
            
            // Scrollable emotion list with vertical scrolling
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) { // Change HStack to VStack for vertical layout
                    ForEach(feelings) { feeling in
                        Button(action: {
                            selectedFeeling = feeling // Update the selected feeling
                            animationSelectedFeeling = feeling
                        }) {
                            VStack {
                                Text(feeling.emoji)
                                    .font(.largeTitle)
                                Text(feeling.name)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black) // Change text color to black for contrast
                                    .padding(.top, 1)
                            }
                            .frame(width: 110, height: 110) // Same size for all buttons
                            .background(animationSelectedFeeling == feeling ? Color.yellow : Color.white) // Highlight selected feeling
                            .cornerRadius(15) // Round the corners
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 2, y: 3) // Add shadow for a shaded effect
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes the default button style
                    }
                }
                .padding()
            }
            .frame(maxHeight: .infinity) // Fill the available height with the ScrollView
            
            // Next button at the bottom, disabled if no feeling is selected
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Confirm")
                    .font(.headline)
                    .foregroundColor(animationSelectedFeeling == nil ? .gray : .orange) // Gray when disabled, blue when enabled
                    .padding()
            }
            .disabled(animationSelectedFeeling == nil) // Disable the button if no feeling is selected
            .padding(.bottom, 20) // Padding from the bottom of the screen
        }
        .frame(maxHeight: .infinity, alignment: .center) // Centers the VStack's content vertically
    }
}

struct FeelingView_Previews: PreviewProvider {
    @State static var previewFeeling: Feeling? =
    Feeling(name: "Angry", color: .red, emoji: "😡")

    static var previews: some View {
        FeelingView(selectedFeeling: $previewFeeling)
    }
}
