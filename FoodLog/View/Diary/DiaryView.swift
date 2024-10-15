//
//  DiaryView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 08/10/24.
//

import SwiftUI
import SwiftData

struct DiaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Food] = []
    @State private var text: String = ""
    
    // State variable to track multiple selected items
    @State private var selectedItems: Set<Food> = []

    var body: some View {
        VStack {
            
            Text("What’s been on your plate today?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
            
            TextField("Banana, tomato, cheese", text: $text)
                .frame(minHeight: 55)
                .padding(.horizontal, 16)
                .textFieldStyle(.plain)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                .padding(.horizontal, 16)
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 55))
                ], spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            // Toggle the selected item in the Set
                            if selectedItems.contains(item) {
                                selectedItems.remove(item) // Deselect if already selected
                            } else {
                                selectedItems.insert(item) // Select new item
                            }
                        }) {
                            Text(item.emoji)
                                .frame(maxWidth: .infinity, minHeight: 55)
                                .font(.system(size: 36))
                                // Change background color based on selection state
                                .background(selectedItems.contains(item) ? Color.yellow : Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
                .background(Color("WhiteSmoke"))
            
            Button("Next") {
                // Action for next button
                // You can use the selectedItems Set here
                print("Selected items: \(selectedItems.map { $0.emoji })")
            }
            .frame(maxWidth: .infinity, minHeight: 55)
            
        }
        .background(Color("WhiteSmoke"))
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    DiaryView()
        .modelContainer(for: Food.self)
}
