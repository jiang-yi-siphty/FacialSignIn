//
//  CameraPreviewViewController.swift
//  FacialSignIn
//
//  Created by Yi JIANG on 30/10/18.
//  Copyright © 2018 Inteliment. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class CameraPreviewViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var capturedImageView: UIImageView!
    
    fileprivate var cameraSession: AVCaptureSession!
    fileprivate var photoOutput: AVCapturePhotoOutput!
    fileprivate var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    fileprivate var imagePickers: UIImagePickerController?
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer?
    fileprivate var sampleFaceTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraSession = AVCaptureSession()
        photoOutput = AVCapturePhotoOutput()
        cameraSession.sessionPreset = .vga640x480
        if let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video , position: .front) {
            do {
                let input = try AVCaptureDeviceInput(device: frontCamera)
                if cameraSession.canAddInput(input),
                    cameraSession.canAddOutput(photoOutput)
                {
                    cameraSession.addInput(input)
                    cameraSession.addOutput(photoOutput)
                    setupLivePreview()
                    self.startSampleFace()
                    DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
                        self.cameraSession.startRunning()
                    }
                }
            } catch  let error {
                print("error: \(error)")
            }
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraSession.stopRunning()
        sampleFaceTimer?.invalidate()
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: cameraSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .landscapeLeft
        videoPreviewLayer.frame = previewView.layer.bounds
        previewView.layer.addSublayer(videoPreviewLayer)
    }
    

    func startSampleFace() {
        sampleFaceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self, self.photoOutput != nil else { return }
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            self.photoOutput.capturePhoto(with: settings, delegate: self)
        }
        sampleFaceTimer?.fire()
    }
    
    func faceDetectWithImage(_ image: UIImage) {
        guard let personciImage = CIImage(image: image) else {
            return
        }
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage)
        previewView.subviews.forEach { $0.removeFromSuperview()}
        if let faces = faces, faces.count > 0 {
            let firstFace = faces[0]
            if let faceImage = (image.cgImage)!.cropping(to: firstFace.bounds) {
                capturedImageView.image = UIImage(cgImage: faceImage)
            }
        }
        for face in faces as! [CIFaceFeature] {
            
            print("Found bounds are \(face.bounds)")
            var faceBox = UIView(frame: face.bounds)
            faceBox.layer.borderWidth = 3
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceBox.backgroundColor = UIColor.clear
                faceBox = adjustFaceBox(faceBox, of: image, in: previewView)
            #warning("The detact face box needs to be adjust location")
            previewView.addSubview(faceBox)
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        }
    }
    
    fileprivate func adjustFaceBox(_ faceBox: UIView, of image: UIImage, in superView: UIView) -> UIView {
        let finalFaceBox = UIView(frame: faceBox.frame)
        finalFaceBox.frame.origin.x = (faceBox.frame.origin.x / image.size.width) * superView.frame.size.width
        finalFaceBox.frame.origin.y = (faceBox.frame.origin.y / image.size.height) * superView.frame.size.height
        finalFaceBox.frame.size.width = (faceBox.frame.size.width / image.size.width) * superView.frame.size.width
        finalFaceBox.frame.size.height = (faceBox.frame.size.height / image.size.height) * superView.frame.size.height
        return finalFaceBox
        
    }
    
}

extension CameraPreviewViewController: UIImagePickerControllerDelegate {
    
}

extension CameraPreviewViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print("token one photo")
        guard let imageData = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: imageData)
//        capturedImageView.image = image
        faceDetectWithImage(image!)
    }
}

extension CameraPreviewViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
//    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
//        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
//        let attachments = CMCopyDictionaryOfAttachments(allocator: kCFAllocatorDefault, target: sampleBuffer, attachmentMode: kCMAttachmentMode_ShouldPropagate)
//        let ciImage = CIImage(cvImageBuffer: pixelBuffer!, options: attachments as! [CIImageOption : Any]?)
//        let options: [String : Any] = [CIDetectorImageOrientation: exifOrientation(orientation: UIDevice.current.orientation),
//                                       CIDetectorSmile: true,
//                                       CIDetectorEyeBlink: true]
//        let allFeatures = faceDetector?.features(in: ciImage, options: options)
//
//        let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)
//        let cleanAperture = CMVideoFormatDescriptionGetCleanAperture(formatDescription!, false)
//
//        guard let features = allFeatures else { return }
//
//        for feature in features {
//            if let faceFeature = feature as? CIFaceFeature {
//                let faceRect = calculateFaceRect(facePosition: faceFeature.mouthPosition, faceBounds: faceFeature.bounds, clearAperture: cleanAperture)
//                update(with: faceRect)
//            }
//        }
//
//        if features.count == 0 {
//            DispatchQueue.main.async {
//                self.detailsView.alpha = 0.0
//            }
//        }
//
//    }

}
