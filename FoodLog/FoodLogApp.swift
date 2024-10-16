//
//  FoodLogApp.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI
import SwiftData

@main
struct FoodLogApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Food.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let fetchDescriptor = FetchDescriptor<Food>()
            
            if try container.mainContext.fetch(fetchDescriptor).count == 0 {
                container.mainContext.insert(Food(name: "Apple", emoji: "🍎", category: .fruit))
                container.mainContext.insert(Food(name: "Banana", emoji: "🍌", category: .fruit))
                container.mainContext.insert(Food(name: "Carrot", emoji: "🥕", category: .vegetable))
                container.mainContext.insert(Food(name: "Broccoli", emoji: "🥦", category: .vegetable))
                container.mainContext.insert(Food(name: "Rice", emoji: "🍚", category: .grain))
                container.mainContext.insert(Food(name: "Bread", emoji: "🍞", category: .grain))
                container.mainContext.insert(Food(name: "Chicken", emoji: "🍗", category: .protein))
                container.mainContext.insert(Food(name: "Fish", emoji: "🐟", category: .protein))
                container.mainContext.insert(Food(name: "Cheese", emoji: "🧀", category: .dairy))
                container.mainContext.insert(Food(name: "Milk", emoji: "🥛", category: .dairy))
                container.mainContext.insert(Food(name: "Olive Oil", emoji: "🫒", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Butter", emoji: "🧈", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Chocolate", emoji: "🍫", category: .sweetsAndSnacks))
                container.mainContext.insert(Food(name: "Cookie", emoji: "🍪", category: .sweetsAndSnacks))
                container.mainContext.insert(Food(name: "Strawberry", emoji: "🍓", category: .fruit))
                container.mainContext.insert(Food(name: "Grapes", emoji: "🍇", category: .fruit))
                container.mainContext.insert(Food(name: "Spinach", emoji: "🥬", category: .vegetable))
                container.mainContext.insert(Food(name: "Tomato", emoji: "🍅", category: .vegetable))
                container.mainContext.insert(Food(name: "Pasta", emoji: "🍝", category: .grain))
                container.mainContext.insert(Food(name: "Quinoa", emoji: "🍲", category: .grain))
                container.mainContext.insert(Food(name: "Eggs", emoji: "🥚", category: .protein))
                container.mainContext.insert(Food(name: "Tofu", emoji: "🍢", category: .protein))
                container.mainContext.insert(Food(name: "Yogurt", emoji: "🥄", category: .dairy))
                container.mainContext.insert(Food(name: "Ice Cream", emoji: "🍦", category: .dairy))
                container.mainContext.insert(Food(name: "Avocado", emoji: "🥑", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Almonds", emoji: "🥜", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Cake", emoji: "🍰", category: .sweetsAndSnacks))
                container.mainContext.insert(Food(name: "Donut", emoji: "🍩", category: .sweetsAndSnacks))
                
                container.mainContext.insert(Food(name: "Orange", emoji: "🍊", category: .fruit))
                container.mainContext.insert(Food(name: "Pineapple", emoji: "🍍", category: .fruit))
                container.mainContext.insert(Food(name: "Watermelon", emoji: "🍉", category: .fruit))
                container.mainContext.insert(Food(name: "Blueberry", emoji: "🫐", category: .fruit))
                container.mainContext.insert(Food(name: "Mango", emoji: "🥭", category: .fruit))
                
                container.mainContext.insert(Food(name: "Cucumber", emoji: "🥒", category: .vegetable))
                container.mainContext.insert(Food(name: "Lettuce", emoji: "🥬", category: .vegetable))
                container.mainContext.insert(Food(name: "Bell Pepper", emoji: "🫑", category: .vegetable))
                container.mainContext.insert(Food(name: "Potato", emoji: "🥔", category: .vegetable))
                container.mainContext.insert(Food(name: "Mushroom", emoji: "🍄", category: .vegetable))
                
                container.mainContext.insert(Food(name: "Oats", emoji: "🥣", category: .grain))
                container.mainContext.insert(Food(name: "Corn", emoji: "🌽", category: .grain))
                container.mainContext.insert(Food(name: "Barley", emoji: "🌾", category: .grain))
                container.mainContext.insert(Food(name: "Buckwheat", emoji: "🥞", category: .grain))
                container.mainContext.insert(Food(name: "Breadstick", emoji: "🥖", category: .grain))
                
                container.mainContext.insert(Food(name: "Beef", emoji: "🥩", category: .protein))
                container.mainContext.insert(Food(name: "Pork", emoji: "🥓", category: .protein))
                container.mainContext.insert(Food(name: "Lentils", emoji: "🥙", category: .protein))
                container.mainContext.insert(Food(name: "Peanuts", emoji: "🥜", category: .protein))
                container.mainContext.insert(Food(name: "Turkey", emoji: "🦃", category: .protein))
                
                container.mainContext.insert(Food(name: "Butter", emoji: "🧈", category: .dairy))
                container.mainContext.insert(Food(name: "Cream", emoji: "🥛", category: .dairy))
                container.mainContext.insert(Food(name: "Whipped Cream", emoji: "🍦", category: .dairy))
                container.mainContext.insert(Food(name: "Cottage Cheese", emoji: "🥄", category: .dairy))
                container.mainContext.insert(Food(name: "Parmesan", emoji: "🧀", category: .dairy))
                
                container.mainContext.insert(Food(name: "Coconut Oil", emoji: "🥥", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Sunflower Oil", emoji: "🌻", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Sesame Oil", emoji: "🥡", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Flaxseed", emoji: "🌾", category: .fatsAndOils))
                container.mainContext.insert(Food(name: "Walnuts", emoji: "🌰", category: .fatsAndOils))
                
                container.mainContext.insert(Food(name: "Candy", emoji: "🍬", category: .sweetsAndSnacks))
                container.mainContext.insert(Food(name: "Popcorn", emoji: "🍿", category: .sweetsAndSnacks))
                container.mainContext.insert(Food(name: "Brownie", emoji: "🍫", category: .sweetsAndSnacks))
                container.mainContext.insert(Food(name: "Ice Pop", emoji: "🍧", category: .sweetsAndSnacks))
                container.mainContext.insert(Food(name: "Cupcake", emoji: "🧁", category: .sweetsAndSnacks))
            }
            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(sharedModelContainer)
        }
    }
}
