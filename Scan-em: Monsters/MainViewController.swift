//
//  MainViewController.swift
//  Scan-em: Monsters
//
//  Created by Timothy Spaeth on 10/25/16.
//  Copyright © 2016 Timothy Spaeth. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SpriteKit

class MainViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var blurEffectView : UIVisualEffectView!
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    var backgroundOpenGif = UIImageView(frame: UIScreen.main.bounds)
    var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    let test : UIButton = UIButton(frame :CGRect(x: 160, y: 428, width: 54, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        
        backgroundImage.image = UIImage(named: "homescreen")
        backgroundImage.alpha = 0.7
        
        let img1 = UIImage(named: "backgroundOpenGif-1 (dragged)")
        let img2 = UIImage(named: "backgroundOpenGif-2 (dragged)")
        let img3 = UIImage(named: "backgroundOpenGif-3 (dragged)")
        let img4 = UIImage(named: "backgroundOpenGif-4 (dragged)")
        let img5 = UIImage(named: "backgroundOpenGif-5 (dragged)")
        let img6 = UIImage(named: "backgroundOpenGif-6 (dragged)")
        
        backgroundOpenGif.image = UIImage.animatedImage(with: [img1!,img2!,img3!,img4!,img5!,img6!], duration: 0.25)
        backgroundOpenGif.alpha = 0.6

        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        test.setTitle("lol", for: .normal)
        test.backgroundColor = UIColor.blue
        test.addTarget(self, action: #selector(MainViewController.buttonClicked), for: .touchUpInside)
        
        view.layer.addSublayer(previewLayer);
        captureSession.startRunning();
        
        view.addSubview(blurEffectView)
        view.addSubview(backgroundImage)
        view.addSubview(test)
       
    }
    
    
    
    func buttonClicked(sender: UIButton!) {
        backgroundImage.removeFromSuperview()
        view.addSubview(backgroundOpenGif)
        backgroundOpenGif.startAnimating()
        endAnimation()
        blurEffectView.removeFromSuperview()
    }
    
    func endAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.23) {
            self.backgroundOpenGif.removeFromSuperview()
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning();
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning();
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
