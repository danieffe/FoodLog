//
//  ContentView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 16/10/24.
//

import SwiftUI

struct FoodSelectView: View {
    @ObservedObject var viewModel = FoodViewModel()
    
    @State private var expandedCategory: String? = nil
    @State private var selectedFoods: [String: Bool] = [:]
    @State private var newFoodName: String = ""
    @State private var showInfoAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollViewReader { scrollViewProxy in
                    VStack {
                        // Keep the text static at the top
                        Text("Select a category to start logging your food.")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top, 5) // Add top padding if necessary
                        
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.foodsByCategory().keys.sorted(), id: \.self) { category in
                                    VStack(spacing: 0) {
                                        CategoryBox(
                                            category: category,
                                            isExpanded: expandedCategory == category,
                                            foods: viewModel.foodsByCategory()[category] ?? [],
                                            selectedFoods: $selectedFoods,
                                            onExpandToggle: {
                                                withAnimation {
                                                    expandedCategory = expandedCategory == category ? nil : category
                                                    // Scroll to the expanded box
                                                    scrollViewProxy.scrollTo(category, anchor: .top)
                                                }
                                            },
                                            newFoodName: $newFoodName,
                                            addNewFood: {
                                                addNewFood(name: newFoodName, category: category)
                                            }
                                        )
                                        .id(category) // Add identifier here
                                        .frame(height: expandedCategory == category ? 350 : 150)
                                        .padding(.horizontal, 20)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        let text = selectedFoods.map { $0.key }.joined(separator: ", ")
                        
                        // The button should only be enabled if at least one food is selected
                        NavigationLink(destination: ResultView(text: text)) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(selectedFoods.values.contains(true) ? Color.orange : Color.gray) // Change text color based on condition
                                .padding(.top, 10)
                                .padding(.bottom, 20)
                        }
                        .disabled(!selectedFoods.values.contains(true)) // Disable button if no foods are selected
                    }
                    .navigationTitle("Welcome to FoodLog!")
                    .navigationBarItems(trailing: Button(action: {
                        showInfoAlert.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                    })
                    .alert(isPresented: $showInfoAlert) {
                        Alert(
                            title: Text("About Us"),
                            message: Text("Developed by the MAD-DEVS Team, FoodLog is a food logging app to help you track your meals in order to prevent health problems. Feel free to contact us at maddevs@gmail.com if you have any questions."),
                            dismissButton: .default(Text("Got it"))
                        )
                    }
                }
            }
        }
    }
    
    private func addNewFood(name: String, category: String) {
        let newFood = Food(name: name, emoji: "🍽️", category: category)
        viewModel.foods.append(newFood)
        selectedFoods[name] = true
        newFoodName = ""
    }
}

struct FoodSelectView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSelectView()
    }
}
