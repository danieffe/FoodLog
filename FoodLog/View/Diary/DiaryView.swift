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
                        Text(item.emoji)
                            .frame(maxWidth: .infinity, minHeight: 55)
                            .font(.system(size: 36))
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: .infinity))
                            .shadow(color: .gray, radius: 1, x: 0, y: 1)
                            .onTapGesture {
                                text.append(item.name)
                            }
                    }
                }
                .padding()
            }
            
            Spacer()
                .background(Color("WhiteSmoke"))
            
                Button("Next") {
                    
                }.frame(maxWidth: .infinity, minHeight: 55)
            
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
