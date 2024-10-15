//
//  AddSymptomView.swift
//  FoodLog
//
//  Created by Daniele Fontana on 15/10/24.
//

import SwiftUI

struct AddSymptomView: View {
    @ObservedObject var viewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var symptomName: String = ""

    var body: some View {
        VStack {
            Text("Add a new symptom")
                .font(.headline)
                .padding(.top)

            TextField("Enter symptom name", text: $symptomName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

            Button("Add") {
                let newSymptom = Symptom(emoji: "❓", name: symptomName)
                viewModel.addSymptom(newSymptom)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .disabled(symptomName.isEmpty)
        }
        .padding()
    }
}

struct AddsymptomView_Previews: PreviewProvider {
    static var previews: some View {
        AddSymptomView(viewModel: ContentViewModel())
    }
}
