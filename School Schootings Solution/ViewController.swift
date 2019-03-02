//
//  ViewController.swift
//  Object Detection
//
//  Created by Devanshi Upadhyay on 2019-02-28.
//  Copyright © 2019 Devanshi Upadhyay. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController,
    AVCaptureVideoDataOutputSampleBufferDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // here is where we start up the camera
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        guard let input = try? AVCaptureDeviceInput(device: captureDevice)else {return}
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        //        VNImageRequestHandler(cgImage: <#T##CGImage#>, options: [:]).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
    }
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        print("Camera was able to capture a frame:", Date())
        
       guard let pixelBuffer: CVPixelBuffer =
        CMSampleBufferGetImageBuffer(sampleBuffer)else {return}
        
        guard let model = try? VNCoreMLModel(for: TestImgs().model) else{return}
        let request = VNCoreMLRequest(model: model)
            { (finishReq, err) in
                
                //check the err
                
                print(finishReq.results)
                
                guard let results = finishReq.results as? [VNClassificationObservation] else {return}
                
                guard let firstObservation = results.first else {return}
                
                print(firstObservation.identifier, firstObservation.confidence)
        }
    
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }

}

