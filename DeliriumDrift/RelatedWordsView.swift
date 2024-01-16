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
    @State private var isLoading: Bool = true
    
    let gptService: GPTService

    // Inject GPTService instance with the required API key and organization name
    init(selectedPrediction: ImagePredictor.Prediction, gptService: GPTService) {
        self.selectedPrediction = selectedPrediction
        self.gptService = gptService
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Selected Prediction: \(selectedPrediction.classification)")

                // Show loading indicator while related words are being generated
                if isLoading {
                    Text("Loading...")
                } else {
                    // Display related words
                    Text("Related Words: \(relatedWords.joined(separator: ", "))")
                    
                    // Enable NavigationLink only when related words are available
                    NavigationLink(destination: PuzzleView(puzzleWords: relatedWords)) {
                        Text("Go to Puzzle View")
                    }
                    .disabled(relatedWords.isEmpty)
                }
            }
            .onAppear {
                // Load related words when the view appears
                generateRelatedWords()
            }
        }
    }


    func generateRelatedWords() {
        // Set loading to true while waiting for related words
        isLoading = true
        
        // Use GPTService to make chat completions call
        gptService.makeChatCompletionsCall(prompt: selectedPrediction.classification, completion: { result in
            // Handle the result, for example, updating relatedWords
            DispatchQueue.main.async {
                self.relatedWords = [result]
                self.isLoading = false // Set loading to false when related words are available
            }
        }, errorHandler: { error in
            // Handle the error
            print("Error generating related words: \(error.localizedDescription)")
            self.isLoading = false // Set loading to false in case of an error
        })
    }
}


