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
            ForEach(viewModel.loadList(), id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }.listRowSeparator(.visible)
        }
    }
}

#Preview {
    ResultView(text: "banana, pineapple, orange, apple, chocolate")
}
struct Bookmark: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var items: [Bookmark]?

    // some example websites
    static let apple = Bookmark(name: "Apple", icon: "1.circle")
    static let bbc = Bookmark(name: "BBC", icon: "square.and.pencil")
    static let swift = Bookmark(name: "Swift", icon: "bolt.fill")
    static let twitter = Bookmark(name: "Twitter", icon: "mic")

    // some example groups
    static let example1 = Bookmark(name: "Favorites", icon: "star", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example2 = Bookmark(name: "Recent", icon: "timer", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
    static let example3 = Bookmark(name: "Recommended", icon: "hand.thumbsup", items: [Bookmark.apple, Bookmark.bbc, Bookmark.swift, Bookmark.twitter])
}

struct ContentView2: View {
    let items: [Bookmark] = [.example1, .example2, .example3]

    var body: some View {
        List(items, children: \.items) { row in
            HStack {
                Image(systemName: row.icon)
                Text(row.name)
            }
        }
    }
}
