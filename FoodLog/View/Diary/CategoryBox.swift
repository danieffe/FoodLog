//
//  CategoryBox.swift
//  FoodLog
//
//  Created by Daniele Fontana on 16/10/24.
//

import SwiftUI

struct CategoryBox: View {
    let category: String

    var body: some View {
        ZStack {
            // Background image with slight opacity to make text more visible
            getImageForCategory(category)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 380, height: 120) // Adjusted size for larger boxes
                .clipShape(RoundedRectangle(cornerRadius: 15)) // Slightly adjusted corner radius
                .clipped()

            // A semi-transparent overlay to improve text visibility
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black.opacity(0.1)) // Slightly darker for better visibility
                .frame(width: 380, height: 120) // Match dimensions with the image
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3) // Shadow effect on the overlay

            // Text with shadow for improved readability
            Text(category)
                .font(.custom("AvenirNext-Bold", size: 22)) // Adjusted text size for better fit
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 0, y: 2) // Apply shadow to text
                .padding()
        }
    }

    // Helper function to select images for each category
    func getImageForCategory(_ category: String) -> Image {
        switch category {
        case "Fruits":
            return Image("Fruits")
        case "Vegetables":
            return Image("Vegetables")
        case "Meat":
            return Image("Meat")
        case "Dairy":
            return Image("Dairy")
        case "Grains":
            return Image("Grains")
        default:
            return Image(systemName: "questionmark") // Fallback image if no category matches
        }
    }
}

struct CategoryBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CategoryBox(category: "Fruits")
            CategoryBox(category: "Vegetables")
            CategoryBox(category: "Meat")
            CategoryBox(category: "Dairy")
            CategoryBox(category: "Grains")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
