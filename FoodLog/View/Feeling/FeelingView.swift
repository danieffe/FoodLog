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
                VStack(spacing: 20) {
                    ForEach(feelings, id: \.name) { feeling in
                        Button(action: {
                            selectedFeeling = feeling // Update the selected feeling
                        }) {
                            VStack {
                                Text(feeling.emoji)
                                    .font(.largeTitle)
                                Text(feeling.name)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .padding(.top, 1)
                            }
                            .frame(width: 110, height: 110)
                            .background(selectedFeeling?.name == feeling.name ? Color.yellow : Color.white)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 2, y: 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .frame(maxHeight: .infinity)
            
            // Confirm button at the bottom, disabled if no feeling is selected
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Confirm")
                    .font(.headline)
                    .foregroundColor(selectedFeeling == nil ? .gray : .orange)
                    .padding()
            }
            .disabled(selectedFeeling == nil)
            .padding(.bottom, 20)
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .onAppear {
            // Reset the selected feeling each time the view appears
            selectedFeeling = nil
        }
    }
}

struct FeelingView_Previews: PreviewProvider {
    @State static var previewFeeling: Feeling? = Feeling(name: "Angry", color: .red, emoji: "😡")

    static var previews: some View {
        FeelingView(selectedFeeling: $previewFeeling)
    }
}
