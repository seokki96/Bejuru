//
//  LiquorScanViewController.swift
//  Bejuru
//
//  Created by a on 10/4/25.
//

import UIKit
import AVFoundation
import Vision

class LiquorScanViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let captureSession = AVCaptureSession()
    private let previewLayer = PreviewView()
    private let resultLabel = UILabel()
    
    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            
            return isAuthorized
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        setUpCaptureSession()
    }
    
    private func setStyle() {
        self.view = previewLayer
        
        resultLabel.do {
            $0.backgroundColor = .gray
        }
    }
    
    private func setLayout() {
        view.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottomMargin)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setUpCaptureSession() {
        Task {
            guard await isAuthorized else { return }
            
            captureSession.beginConfiguration()
            let videoDevice = AVCaptureDevice.default(
                .builtInWideAngleCamera,
                for: .video,
                position: .unspecified
            )
            guard
                let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
                captureSession.canAddInput(videoDeviceInput) else { return }
            captureSession.addInput(videoDeviceInput)
            
            // 세션에 추가될 videoOutput 설정
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: .global(qos: .userInitiated))
            videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            videoOutput.alwaysDiscardsLateVideoFrames = true
            
            guard captureSession.canAddOutput(videoOutput) else { return }
            captureSession.sessionPreset = .photo
            captureSession.addOutput(videoOutput)
            
            previewLayer.videoPreviewLayer.session = captureSession
            
            captureSession.commitConfiguration()
            
            Task.detached { [weak self] in
                await self?.captureSession.startRunning()
            }
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
                
        guard let model = try? VNCoreMLModel(for: LiquorClassifier().model) else {
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let result = request.results as? [VNClassificationObservation] else {
                return
            }
            
            if let topResult = result.first {
                DispatchQueue.main.async {
                    self.resultLabel.text = "identifier: \(topResult.identifier) accuracy: \(topResult.confidence * 100)%"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            print("ERROR: \(error)")
        }
    }
}

class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
