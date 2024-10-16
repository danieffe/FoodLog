//
//  ContentView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 16/10/24.
//

import SwiftUI

struct FoodSelectView: View {
    @ObservedObject var viewModel = FoodViewModel()
    
    // State variable to track which category is expanded
    @State private var expandedCategory: String? = nil
    
    // Dictionary to track selected foods
    @State private var selectedFoods: [String: Bool] = [:]
    
    // State variable to hold new food name
    @State private var newFoodName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        Spacer(minLength: 20)  // Add some space at the top
                        
                        // Subtitle
                        Text("Select a category to start logging your food.")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.bottom, 20)

                        // List the categories one by one
                        ForEach(viewModel.foodsByCategory().keys.sorted(), id: \.self) { category in
                            VStack(spacing: 0) { // Remove spacing between category box and food list
                                // Category Box
                                CategoryBox(category: category)
                                    .frame(height: expandedCategory == category ? 300 : 150) // Expand when selected
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 5)
                                    .onTapGesture {
                                        withAnimation {
                                            expandedCategory = expandedCategory == category ? nil : category // Toggle the category
                                        }
                                    }
                                
                                // Show foods when the category is expanded
                                if expandedCategory == category {
                                    VStack(spacing: 5) { // Spacing between food items
                                        ForEach(viewModel.foodsByCategory()[category] ?? [], id: \.name) { food in
                                            HStack {
                                                Text(food.emoji)
                                                    .font(.largeTitle)
                                                Text(food.name)
                                                    .font(.headline)
                                                Spacer()
                                                // Checkbox
                                                Image(systemName: selectedFoods[food.name] == true ? "checkmark.square.fill" : "square")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.blue)
                                                    .onTapGesture {
                                                        // Toggle selection
                                                        selectedFoods[food.name] = !(selectedFoods[food.name] ?? false)
                                                    }
                                            }
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 5)
                                        }
                                        
                                        // New Food Entry
                                        HStack {
                                            TextField("Add new food", text: $newFoodName)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .padding(.horizontal, 20)
                                            Button(action: {
                                                addNewFood(name: newFoodName, category: category)
                                            }) {
                                                Text("Add")
                                                    .foregroundColor(.blue)
                                            }
                                            .disabled(newFoodName.isEmpty) // Disable if text field is empty
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 5)
                                    }
                                }
                            }
                        }

                        Spacer() // Add a spacer to push the button down
                    }
                }
                
                // Next Button as Text
                Button(action: {
                    // Handle next action
                    print("Next button tapped")
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(selectedFoods.values.contains(true) ? Color.orange : Color.gray) // Change color based on selection
                        .padding(.top, 10) // Add some top padding
                        .padding(.bottom, 20) // Add some bottom padding
                }
                .disabled(!selectedFoods.values.contains(true)) // Disable if no food is selected
                .padding(.horizontal) // Add horizontal padding for the button
            }
            .navigationTitle("FoodLog")
        }
    }
    
    // Function to add a new food
    private func addNewFood(name: String, category: String) {
        let newFood = Food(name: name, emoji: "🍽️", category: category) // Default emoji for new food
        viewModel.foods.append(newFood) // Add new food to the view model
        selectedFoods[name] = true // Automatically select the new food
        newFoodName = "" // Clear the text field
    }
}

struct FoodSelectView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSelectView()
    }
}
