//
//  MainView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var text: String = "test skafokosa kofaksok fosakd kfoakso fkasok fokasok foakso fkaosk fkosakf oask okfoask okfok aoskf"
    
    var body: some View {
        VStack {
            Button("Add item") {
                addItem()
            }
            TextEditor(text: $text)
                .frame(height: 66)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.all, 16)
            
            
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
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
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
