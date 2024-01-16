//
//  PuzzleView.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/15/24.
//

import SwiftUI

struct PuzzleView: View {
    var puzzleWords: [String]

    var body: some View {
        VStack {
            Text("Puzzle Words:")
            ForEach(puzzleWords, id: \.self) { word in
                Text(word)
            }
        }
        .padding()
    }
}


#Preview {
    PuzzleView(puzzleWords: ["Word1", "Word2", "Word3"])
}
