//
//  ContentView.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isCameraActive = false

    var body: some View {
        VStack {
            if isCameraActive {
                CameraView(isCameraActive: $isCameraActive)
                    .edgesIgnoringSafeArea(.all)
            } else {
                // Your other view when the camera is not active
                Text("Switch to Camera View")
                    .onTapGesture {
                        isCameraActive.toggle()
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
