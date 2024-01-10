//
//  AudioPlayer.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/8/24.
//

import AVFoundation

class AudioPlayer {
    static var shared = AudioPlayer()
    
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(named soundName: String) {
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}

