//
//  ResultView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI

struct ResultView: View {
    
    @State var selectedFeeling: Feeling?
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
            
            NavigationLink(destination: FeelingView(selectedFeeling:  Binding(
                get: { selectedFeeling },
                set: { selectedFeeling = $0 }
            ))) {
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
                    .padding(16)
                }
            }.padding(.top, -8)
            
            NavigationLink(destination: FeelingView(selectedFeeling:  Binding(
                get: { selectedFeeling },
                set: { selectedFeeling = $0 }
            ))) {
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
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
            }.padding(.bottom, 16)
            
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
