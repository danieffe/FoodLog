//
//  ContentView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 15/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel() // ViewModel instance
    @State private var searchText: String = ""
    @State private var showAddSymptom = false // Controls the add symptom sheet

    // Define a grid layout with 3 columns
    let columns = Array(repeating: GridItem(.flexible(minimum: 90, maximum: 120)), count: 3)

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    // Title
                    Text("How did you feel after eating?")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading], 16)
                    
                    // Search bar
                    TextField("Search symptoms", text: $searchText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 3)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10) // This line adds space below the search bar

                    // Symptom grid
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(filteredSymptoms()) { symptom in
                                SymptomView(
                                    symptom: symptom,
                                    isSelected: viewModel.selectedSymptoms.contains(symptom),
                                    action: {
                                        viewModel.toggleSymptomSelection(symptom)
                                    }
                                )
                            }

                            // Plus button to add new symptom
                            Button(action: {
                                showAddSymptom.toggle()
                            }) {
                                VStack {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                    
                                    Text("Add new")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                        .frame(maxHeight: 40)
                                }
                                .padding()
                                .frame(width: 100, height: 100)
                                .background(Color.white)
                                .cornerRadius(20)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer()

                    // "Next" Button
                    Button("Next") {
                        print("Next button tapped")
                    }
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding(.bottom, 20)
                    .disabled(viewModel.selectedSymptoms.isEmpty) // Disable if no symptoms selected
                }
                .sheet(isPresented: $showAddSymptom) {
                    AddSymptomView(viewModel: viewModel)
                }
            }
        }
    }

    // Filter symptoms based on search text
    private func filteredSymptoms() -> [Symptom] {
        if searchText.isEmpty {
            return viewModel.symptomsList
        } else {
            return viewModel.symptomsList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
