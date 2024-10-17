//
//  CategoryBox.swift
//  FoodLog
//
//  Created by Daniele Fontana on 16/10/24.
//

import SwiftUI

struct CategoryBox: View {
    let category: String
    let isExpanded: Bool
    let foods: [Food]
    
    @Binding var selectedFoods: [String: Bool]
    
    let onExpandToggle: () -> Void
    @Binding var newFoodName: String
    let addNewFood: () -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                // Category name with toggle
                HStack {
                    Text(category)
                        .font(.custom("AvenirNext-Bold", size: 22))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 2) // Add shadow to the text
                        .padding(.leading, 20)
                        .padding(.vertical, 10) // Add some padding for better readability
                    
                    Spacer()
                    
                    // Toggle expansion button
                    Button(action: {
                        onExpandToggle()
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                            .shadow(color: .black, radius: 2, x: 0, y: 2) // Add shadow to the icon
                    }
                }
                .frame(height: 80) // Fixed height for the initial view

                // Expandable food list inside the box
                if isExpanded {
                    VStack(spacing: 10) {
                        ForEach(foods, id: \.name) { food in
                            Toggle(isOn: Binding(
                                get: { selectedFoods[food.name] ?? false },
                                set: { newValue in selectedFoods[food.name] = newValue }
                            )) {
                                HStack {
                                    Text(food.emoji)
                                        .font(.largeTitle)
                                    Text(food.name)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .foregroundColor(.white) // Set text to white
                                        .shadow(color: .black, radius: 2, x: 0, y: 2) // Add shadow to food text
                                }
                            }
                        }

                        // New Food Entry
                        HStack(spacing: 10) {
                            TextField("Add new food", text: $newFoodName)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .frame(height: 50)
                            
                            Button(action: {
                                addNewFood()
                            }) {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .frame(width: 80, height: 50)
                                    .background(Color.orange)
                                    .cornerRadius(8)
                                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                            }
                            .disabled(newFoodName.isEmpty)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 10)
                }
            }
            .background(
                getImageForCategory(category)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: isExpanded ? 300 : 120) // Dynamic frame height
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .clipped()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black.opacity(0.1)) // Make the background darker for better text visibility
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                    )
            )
        }
        .animation(.spring(), value: isExpanded) // Animate expansion and collapse
    }

    // Helper function to select images for each category
    func getImageForCategory(_ category: String) -> Image {
        switch category {
        case "Fruits":
            return Image("Fruits")
        case "Vegetables":
            return Image("Vegetables")
        case "Meat":
            return Image("Meat")
        case "Dairy":
            return Image("Dairy")
        case "Grains":
            return Image("Grains")
        default:
            return Image(systemName: "questionmark")
        }
    }
}

struct CategoryBox_Previews: PreviewProvider {
    static var previews: some View {
        CategoryBox(
            category: "Fruits",
            isExpanded: true,
            foods: [Food(name: "Apple", emoji: "🍎", category: "Fruits")],
            selectedFoods: .constant([:]),
            onExpandToggle: {},
            newFoodName: .constant(""),
            addNewFood: {}
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
