//
//  CalmingView.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/8/24.
//

import SwiftUI
import AVFoundation

struct CalmingView: View {
    @State private var isPlaying = false
    @State private var audioPlayer: AVAudioPlayer?

    // Function to play the calming audio
    func playAudio() {
        guard let path = Bundle.main.path(forResource: "calm_audio_track", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            // Handle audio playback error
            print("Error playing audio: \(error.localizedDescription)")
        }
    }

    var body: some View {
        VStack {
            // Play/pause button
            Button(action: {
                isPlaying.toggle()
                if isPlaying {
                    playAudio()
                } else {
                    audioPlayer?.pause()
                }
            }) {
                Text(isPlaying ? "Pause" : "Play")
            }

            // Visual element with opacity change
            Rectangle()
                .frame(width: 200, height: 200)
                .foregroundColor(Color.blue)
                .opacity(isPlaying ? 0.3 : 1.0) // Adjust opacity based on audio playback state
                .animation(.easeInOut(duration: 2.0)) // Add an animation
        }
    }
}
