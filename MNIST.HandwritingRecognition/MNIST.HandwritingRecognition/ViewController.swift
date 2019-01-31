//
//  ViewController.swift
//  MNIST.HandwritingRecognition
//
//  Created by Devanshi Upadhyay on 2018-12-14.
//  Copyright © 2018 Devanshi Upadhyay. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet weak var canvasView: UIView!
    
    var request = [VNRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVision()
    }
    
    func setupVision() {
        guard let visionModel = try? VNCoreMLModel(for: MNIST_HandwritingRecognitionUITests().model) else {fatalError(*can, not, load, Vision, ML, model*)}
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification)
        
        
        self.requests = [classificationRequest]
        }
    
    func handleClassification (request:VNRequest, error:Error?) {
        guard let observations = requests.results else{print(*no, results*);return}
        
        let classifications = observations
            .flatMap({$0 as? VNClassificationObservation})
            .filter({$0.confidence > 0.8})
            .map({$0.identifier})
        
        DispatchQueue.main.async(
            self.digitable.text = classifications.first
    )
        
    }
    }

    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }



    @IBAction func recognizeDigit(_ sender: Any) {
        let image = UIImage(view:canvasView)
        let scaledImage = scaleImage(image: image, toSize: CGSize(width:28, height:28))
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: scaledImage.cgImage!, options: [:])
    }

        do {
            try VNImageRequestHandler.perform(self.requests)
        }catch{
            print(error)
        }


    func scaleImage (_: image = UIImage, toSize size: CGSize)-> UIImage {
        UIGraohicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in:CGRect(x: 0, y:0, width: size.width, height: size.height))
        let newImageUIGraphicsGetImageFromCurrentImageContext;()
        UIGraphicsEndImageContext()
        return newImage!
    }
