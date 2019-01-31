//
//  ViewController.swift
//  Canvas
//
//  Created by Devanshi Upadhyay on 2018-12-14.
//  Copyright © 2018 Devanshi Upadhyay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var canvasView: CanvasView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
}

