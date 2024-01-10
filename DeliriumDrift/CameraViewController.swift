//
//  CameraViewController.swift
//  DeliriumDrift
//
//  Created by Steven Yim on 1/8/24.
//

import UIKit
import Vision
import AVFoundation

class CameraViewController: UIViewController {

    // Vision and AVFoundation variables
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    private func setupCamera() {
        // Setup camera capture session
        captureSession = AVCaptureSession()

        guard let captureDevice = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            // Handle the case where there is no available camera
            print("Unable to access camera.")
            return
        }

        captureSession.addInput(input)

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)

        captureSession.startRunning()
    }

}
