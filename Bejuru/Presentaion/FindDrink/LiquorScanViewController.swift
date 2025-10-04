//
//  LiquorScanViewController.swift
//  Bejuru
//
//  Created by a on 10/4/25.
//

import UIKit
import AVFoundation

class LiquorScanViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let captureSession = AVCaptureSession()
    private let previewLayer = PreviewView()
    
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
        setUpCaptureSession()
    }
    
    private func setStyle() {
        self.view = previewLayer
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
