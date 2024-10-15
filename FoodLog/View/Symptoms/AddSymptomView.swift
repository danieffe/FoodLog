import SwiftUI

struct AddSymptomView: View {
    @ObservedObject var viewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var symptomName: String = ""
    @State private var emojiInput: String = ""

    var body: some View {
        VStack {
            Text("Add a new symptom")
                .font(.headline)
                .padding(.top)

            // Symptom name input field
            TextField("Enter symptom name", text: $symptomName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

            // Emoji input field (validated for emoji-only input)
            TextField("Enter emoji (optional)", text: $emojiInput)
                .onChange(of: emojiInput) { newValue in
                    emojiInput = filterEmojiInput(newValue) // Filter input to allow only emojis
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()

            // Add button
            Button("Add") {
                let selectedEmoji = emojiInput.isEmpty ? "❓" : emojiInput
                let newSymptom = Symptom(emoji: selectedEmoji, name: symptomName)
                viewModel.addSymptom(newSymptom)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .disabled(symptomName.isEmpty) // Disable if no symptom name is provided
        }
        .padding()
    }

    // Filter function to ensure only emojis are allowed
    private func filterEmojiInput(_ input: String) -> String {
        return input.filter { $0.isEmoji }
    }
}

extension Character {
    // Determine if a character is an emoji by checking its Unicode properties
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmojiPresentation
    }
}

struct AddSymptomView_Previews: PreviewProvider {
    static var previews: some View {
        AddSymptomView(viewModel: ContentViewModel())
    }
}

