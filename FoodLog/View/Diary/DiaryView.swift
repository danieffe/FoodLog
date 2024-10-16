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
    @Query private var items: [Food] = []
    @State var selectedItems: Set<Food> = []
    
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
                                    isPresented: $isShowingPopover, attachmentAnchor: .point(.leading)                                    ) {
                                        
                                        Text("Insert your meals separated by commas")
                                            .lineLimit(4)
                                            .padding()
                                            .frame(maxWidth: 250, minHeight: 80)
                                            .presentationCompactAdaptation(.popover)
                                    }
                                Spacer()
                            }
                        }
                        
                        TextField("Banana, tomato, cheese...", text: $text, axis: .vertical)
                            .padding(16)
                            .textFieldStyle(.plain)
                            .focused($isFocused)
                    }
                }
                .frame(maxHeight: 200)
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
                
                List(FoodCategory.allCases) { item in
                    Section(item.name) {
                        ForEach(items.filter { $0.category == item }) { food in
                            Text(food.emoji + food.name)
                                .frame(maxWidth: .infinity, minHeight: 55)
                                .font(.system(size: 36))
                                .clipShape(RoundedRectangle(cornerRadius: .infinity))
                                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, minHeight: 500, maxHeight: .infinity)
                .listStyle(.grouped)
                
                
                //                    ForEach(items, id: \.self) { item in
                //                        Button(action: {
                //                            if selectedItems.contains(item) {
                //                                selectedItems.remove(item)
                //                            } else {
                //                                selectedItems.insert(item)
                //                                text.append(item.name)
                //                            }
                //                        }) {
                //                        }
                //                    }
            }
        }
    }
}

#Preview {
    DiaryView()
        .modelContainer(for: Food.self)
}
