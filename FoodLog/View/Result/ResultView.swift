//
//  ResultView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUICore
import SwiftUI

struct ResultView: View {
    
    @State var selectedFeeling: Feeling?
    @State var selectedSymptoms: [Symptom] = [] // Aggiungiamo anche i sintomi selezionati
    
    var viewModel: ResultViewModel
    init (text: String) {
        viewModel = .init(text: text)
    }
    
    var body: some View {
        VStack {
            
            Text("Today's plate:")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
            
            List {
                ForEach(viewModel.loadList(), id: \.self) { item in
                    HStack {
                        Text(item)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
                }.listRowSeparator(.visible)
            }
            
            // First NavigationLink for feelings
            NavigationLink(destination: FeelingView(selectedFeeling: $selectedFeeling)) {
                VStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                        .shadow(radius: 2, y: -1)
                    HStack {
                        Text("How have you been feeling today?")
                            .foregroundStyle(.black)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "arrowshape.right.circle")
                            .foregroundStyle(.accent)
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, selectedFeeling == nil ? 16 : 0)
                    
                    // Display the selected feeling
                    if let selectedFeeling = selectedFeeling {
                        HStack {
                            Text("\(selectedFeeling.emoji) \(selectedFeeling.name)")
                                .foregroundStyle(.black)
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
            }
            .padding(.top, -8)
            
            // NavigationLink for "odd vibes or symptoms?"
            NavigationLink(destination: ContentView(selectedSymptoms: $selectedSymptoms)) {
                VStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Noticing any odd vibes or symptoms?")
                            .foregroundStyle(.black)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "arrowshape.right.circle")
                            .foregroundStyle(.accent)
                    }
                    .padding(16)
                    
                    // Display the selected symptoms (like feelings, emoji + name)
                    if !selectedSymptoms.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(selectedSymptoms, id: \.self) { symptom in
                                    Text("\(symptom.emoji) \(symptom.name)")
                                        .foregroundStyle(.black)
                                        .font(.subheadline)
                                        .padding(.horizontal, 8)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }
                    }

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 16)
            
            Text("Save")
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(16)
                .foregroundStyle(.white)
        }
    }
}




#Preview {
    ResultView(text: "banana, pineapple, orange, apple, chocolate, banana, pineapple, orange, apple, chocolate, banana, pineapple, orange, apple, chocolate")
}
