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
    
    // State variable to control the presentation of the info alert
    @State private var showInfoAlert: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        VStack(spacing: 5) { // Reduced spacing between categories
                            
                            // Subtitle aligned to the left
                            Text("Select a category to start logging your food.")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading) // Align to the left
                                .padding(.horizontal, 30) // Add horizontal padding

                            // List the categories one by one
                            ForEach(viewModel.foodsByCategory().keys.sorted(), id: \.self) { category in
                                VStack(spacing: 0) { // No spacing between category box and food list
                                    // Category Box
                                    CategoryBox(category: category)
                                        .frame(height: expandedCategory == category ? 300 : 150) // Expand when selected
                                        .padding(.horizontal, 20)
                                        .onTapGesture {
                                            withAnimation {
                                                expandedCategory = expandedCategory == category ? nil : category // Toggle the category
                                            }
                                        }
                                    
                                    // Show foods when the category is expanded
                                    if expandedCategory == category {
                                        VStack(spacing: 5) { // Reduced spacing between food items
                                            ForEach(viewModel.foodsByCategory()[category] ?? [], id: \.name) { food in
                                                HStack {
                                                    // Checkbox for selection
                                                    Button(action: {
                                                        // Toggle selection
                                                        selectedFoods[food.name] = !(selectedFoods[food.name] ?? false)
                                                    }) {
                                                        Image(systemName: selectedFoods[food.name] == true ? "checkmark.square" : "square")
                                                            .foregroundColor(.blue)
                                                    }
                                                    .buttonStyle(PlainButtonStyle()) // Use plain button style to avoid default styling
                                                    
                                                    Text(food.emoji)
                                                        .font(.largeTitle)
                                                    Text(food.name)
                                                        .font(.headline)
                                                        .fontWeight(.regular) // Keep regular weight for simplicity
                                                    Spacer()
                                                }
                                                .padding(.horizontal, 10) // Horizontal padding
                                                .padding(.vertical, 5) // Adjusted vertical padding
                                            }
                                            
                                            // New Food Entry
                                            HStack(spacing: 10) { // Added spacing for the HStack
                                                TextField("Add new food", text: $newFoodName)
                                                    .padding(15) // Increased padding for text field
                                                    .background(Color.white) // White background for text field
                                                    .cornerRadius(8) // Rounded corners for the text field
                                                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2) // Shadow for text field
                                                    .overlay( // Add border for better visibility
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color.gray, lineWidth: 1)
                                                    )
                                                    .frame(height: 50) // Increased height for better touch target
                                                    .disabled(expandedCategory == nil) // Disable if no category is expanded
                                                    .onTapGesture {
                                                        // Add gesture to dismiss keyboard when tapping outside
                                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                    }
                                                
                                                Button(action: {
                                                    addNewFood(name: newFoodName, category: category)
                                                }) {
                                                    Text("Add")
                                                        .foregroundColor(.white)
                                                        .frame(width: 80, height: 50) // Increased button height for better touch target
                                                        .background(Color.blue) // Use blue background for visibility
                                                        .cornerRadius(8) // Rounded corners for the button
                                                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2) // Shadow for button
                                                        .overlay( // Add border for better visibility
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color.gray, lineWidth: 1)
                                                        )
                                                }
                                                .disabled(newFoodName.isEmpty) // Disable if text field is empty
                                            }
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 5)
                                            .frame(maxWidth: .infinity, alignment: .leading) // Align to the left
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
                .navigationTitle("Welcome to FoodLog!")
                .navigationBarItems(trailing: Button(action: {
                    // Show the info alert
                    showInfoAlert.toggle()
                }) {
                    Image(systemName: "info.circle") // Info button icon
                        .imageScale(.large)
                })
                .alert(isPresented: $showInfoAlert) { // Info alert
                    Alert(title: Text("About Us"),
                          message: Text("Developed by the MAD-DEVS Team, FoodLog is a food logging app to help you track your meals in order to prevent health problems. Feel free to contact us at maddevs@gmail.com if you have any questions."),
                          dismissButton: .default(Text("Got it")))
                }
            }
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
