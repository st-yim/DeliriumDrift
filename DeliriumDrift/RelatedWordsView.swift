//
//  RelatedWordsView.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/10/24.
//

import SwiftUI

struct RelatedWordsView: View {
    var selectedPrediction: ImagePredictor.Prediction
    @State private var relatedWords: [String] = []
    
    let gptService = GPTService()

    var body: some View {
        VStack {
            Text("Selected Prediction: \(selectedPrediction.classification)")

            // Load related words when the view appears
            Text("Related Words: \(relatedWords.joined(separator: ", "))")
                .onAppear {
                    generateRelatedWords()
                }
        }
    }

    func generateRelatedWords() {
        gptService.generateRelatedWords(inputText: selectedPrediction.classification) { result in
            switch result {
            case .success(let words):
                // Update the state variable
                relatedWords = words
            case .failure(let error):
                // Handle the error
                print("Error generating related words: \(error.localizedDescription)")
            }
        }
    }
}
