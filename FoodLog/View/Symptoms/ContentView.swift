//
//  ContentView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 15/10/24.
//

import SwiftUI

struct ContentView: View {
    @Binding var selectedSymptoms: [Symptom] // Binding dei sintomi selezionati
    @StateObject var viewModel = ContentViewModel()
    @State private var searchText: String = ""
    @State private var showAddSymptom = false
    
    // Environment per gestire la navigazione
    @Environment(\.presentationMode) var presentationMode

    let columns = Array(repeating: GridItem(.flexible(minimum: 90, maximum: 120)), count: 3)

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    Text("How did you feel after eating?")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading], 16)
                    
                    TextField("Search symptoms", text: $searchText)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 3)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(filteredSymptoms()) { symptom in
                                SymptomView(
                                    symptom: symptom,
                                    isSelected: selectedSymptoms.contains(symptom), // Controlla se il sintomo è già selezionato
                                    action: {
                                        toggleSymptomSelection(symptom)
                                    }
                                )
                            }
                            
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

                    Button("Next") {
                        // Ritornare alla ResultView
                        presentationMode.wrappedValue.dismiss() // Chiude la ContentView e torna indietro
                    }
                    .font(.headline)
                    .foregroundColor(selectedSymptoms.isEmpty ? .gray : .orange)
                    .padding(.bottom, 20)
                    .disabled(selectedSymptoms.isEmpty)
                }
                .sheet(isPresented: $showAddSymptom) {
                    AddSymptomView(viewModel: viewModel)
                        .presentationDetents([.fraction(0.5)])
                }
            }
        }
        .onAppear {
            // Resettare i sintomi selezionati quando la vista appare
            selectedSymptoms.removeAll()
        }
    }
    
    private func toggleSymptomSelection(_ symptom: Symptom) {
        // Se il sintomo è già selezionato, lo deselezioniamo
        if selectedSymptoms.contains(symptom) {
            selectedSymptoms.removeAll(where: { $0 == symptom })
        } else {
            // Altrimenti lo aggiungiamo
            selectedSymptoms.append(symptom)
        }
    }
    
    // Filtrare i sintomi in base al testo cercato
    private func filteredSymptoms() -> [Symptom] {
        if searchText.isEmpty {
            return viewModel.symptomsList
        } else {
            return viewModel.symptomsList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    @State static var mockSelectedSymptoms: [Symptom] = [] // Stato fittizio per la preview
    
    static var previews: some View {
        ContentView(selectedSymptoms: $mockSelectedSymptoms) // Passa il binding
    }
}
