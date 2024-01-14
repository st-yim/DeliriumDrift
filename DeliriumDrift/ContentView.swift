//
//  ContentView.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isCameraActive = false
    @State private var selectedPrediction: ImagePredictor.Prediction?
    
    var body: some View {
        VStack {
            if isCameraActive {
                CameraView(isCameraActive: $isCameraActive, predictionsHandler: handlePredictions)
                    .edgesIgnoringSafeArea(.all)
            } else {
                if let selectedPrediction = selectedPrediction {
                    
                    let gptService = GPTService(apiKey: "YOUR-API-KEY", apiOrg: "ORG")
                    
                    RelatedWordsView(selectedPrediction: selectedPrediction, gptService: gptService)
                    
                } else {
                    Text("Switch to Camera View")
                        .onTapGesture {
                            isCameraActive.toggle()
                        }
                }
            }
        }
    }

    func handlePredictions(predictions: [ImagePredictor.Prediction]?) {
        // Here, you can define your logic to choose the top prediction
        self.selectedPrediction = predictions?.first
        
        isCameraActive = false
    }
}

#Preview {
    ContentView()
}
