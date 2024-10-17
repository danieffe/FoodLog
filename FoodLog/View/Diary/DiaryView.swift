//
//  DiaryView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 15/10/24.
//

import SwiftUI
import SwiftData

struct DiaryView: View {
    @State var text: String = ""
    @FocusState var isFocused: Bool
    @State var isShowingPopover: Bool = false
    @Query private var foods: [Food] = []
    @State var selectedItems: Set<Food> = []
    @State private var expandedStates: [FoodCategory: Bool] = [:]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("What’s been on your plate today?")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            
                            VStack {
                                Button("", systemImage: "info.circle.fill", action: {
                                    isShowingPopover.toggle()
                                })
                                .popover(
                                    isPresented: $isShowingPopover, attachmentAnchor: .point(.leading)) {
                                        
                                        Text("Insert your meals separated by commas")
                                            .lineLimit(4)
                                            .padding()
                                            .frame(maxWidth: 250, minHeight: 80)
                                            .presentationCompactAdaptation(.popover)
                                    }
                            }
                        }
                        
                        TextField("Banana, tomato, cheese...", text: $text, axis: .vertical)
                            .lineLimit(4)
                            .padding(16)
                            .textFieldStyle(.plain)
                            .focused($isFocused)
                    }
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                .padding(.horizontal, 16)
                .onTapGesture {
                    isFocused = true
                }
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ResultView(text: text)) {
                        Text("Next")
                            .frame(width: 100, height: 40)
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .foregroundStyle(.white)
                    }
                    .padding(16)
                }
                
                List(FoodCategory.allCases) { category in
                    FoodSectionView(
                        isExpanded: Binding(
                            get: { expandedStates[category] ?? true },
                            set: { expandedStates[category] = $0 }
                        ), category: category, items: foods, text: $text)
                }
                .listStyle(.insetGrouped)
            }
        }
    }
}

#Preview {
    DiaryView()
        .modelContainer(for: Food.self)
}

struct FoodSectionView: View {
    @Binding var isExpanded: Bool
    var category: FoodCategory
    var items: [Food]
    var text: Binding<String>
    
    
    var body: some View {
        Section(isExpanded: $isExpanded) {
            ForEach(items.filter { $0.category == category }) { food in
                HStack(alignment: .firstTextBaseline) {
                    Text("\(food.emoji) \(food.name)")
                    .font(.system(size: 16))}
                .frame(maxWidth: .infinity, maxHeight: 35, alignment: .leading)
                .onTapGesture {
                    
                    if !text.wrappedValue.isEmpty && !text.wrappedValue.hasSuffix(", ") {
                        text.wrappedValue.append(", ")
                    }
                    text.wrappedValue.append("\(food.name), ")
                }
            }
        } header: {
            HStack {
                Text(category.name)
                    .font(.headline)
                
                Color.clear
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
                    .animation(.easeInOut, value: isExpanded)
                    .frame(width: 20, height: 20)
            }
            .onTapGesture {
                isExpanded.toggle()
            }
        }
    }
}

