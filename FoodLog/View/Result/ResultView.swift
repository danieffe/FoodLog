//
//  ResultView.swift
//  FoodLog
//
//  Created by Mateus Mansuelli on 07/10/24.
//

import SwiftUI

struct ResultView: View {
    
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
            
            ForEach(viewModel.loadList(), id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }.listRowSeparator(.visible)
            
            NavigationLink(destination: FeelingView()) {
                VStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
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
            }.padding(.top, 16)
            
            NavigationLink(destination: FeelingView()) {
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
            Spacer()
            
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
    ResultView(text: "banana, pineapple, orange, apple, chocolate")
}
