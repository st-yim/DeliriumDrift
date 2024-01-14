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
    
    let gptService: GPTService

    // Inject GPTService instance with the required API key and organization name
    init(selectedPrediction: ImagePredictor.Prediction, gptService: GPTService) {
        self.selectedPrediction = selectedPrediction
        self.gptService = gptService
    }

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
        // Use GPTService to make chat completions call
        gptService.makeChatCompletionsCall(prompt: selectedPrediction.classification, completion: { result in
            // Handle the result, for example, updating relatedWords
            self.relatedWords = [result]
        }, errorHandler: { error in
            // Handle the error
            print("Error generating related words: \(error.localizedDescription)")
        })
    }
}

