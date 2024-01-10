import SwiftUI
import VisionKit
import CoreML
import Vision

struct CameraView: UIViewControllerRepresentable {
    @Binding var isCameraActive: Bool

    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let cameraViewController = VNDocumentCameraViewController()
        cameraViewController.delegate = context.coordinator
        return cameraViewController
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: CameraView

        // Use the ImagePredictor for image classification
        let imagePredictor = ImagePredictor()

        init(parent: CameraView) {
            self.parent = parent
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // Check if there is at least one scanned page
            guard scan.pageCount > 0 else {
                parent.isCameraActive = false
                return
            }

            // Retrieve the first page's image
            let uiImage = scan.imageOfPage(at: 0)

            // Convert UIImage to CGImage
            guard let cgImage = uiImage.cgImage else {
                parent.isCameraActive = false
                return
            }

            // Perform image classification using MobileNetV2
            classifyImage(cgImage: cgImage)

            parent.isCameraActive = false
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            parent.isCameraActive = false
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            // Handle error if any
            parent.isCameraActive = false
        }

        func classifyImage(cgImage: CGImage) {
            // Use ImagePredictor for image classification
            do {
                try imagePredictor.makePredictions(for: UIImage(cgImage: cgImage)) { predictions in
                    // Handle the predictions
                    if let predictions = predictions {
                        for prediction in predictions {
                            print("Classification: \(prediction.classification) with confidence \(prediction.confidencePercentage)")
                        }
                    } else {
                        print("Image classification failed.")
                    }
                }
            } catch {
                print("Error performing image classification: \(error.localizedDescription)")
            }
        }
    }
}
