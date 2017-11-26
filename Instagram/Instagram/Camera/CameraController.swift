//  CameraController.swift
//  Instagram
//  Created by Anthony Washington on 11/26/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import AVFoundation

class CameraController: UIViewController {

    let capture: UIButton = {
        let c = UIButton(type: .system)
            c.setImage(#imageLiteral(resourceName: "capture_photo"), for: .normal)
            c.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        return c
    }()
    
    let dismiss: UIButton = {
        let d = UIButton(type: .system)
            d.setImage(#imageLiteral(resourceName: "cancel_shadow"), for: .normal)
            d.addTarget(self, action: #selector(dismissCamera), for: .touchUpInside)
        return d
    }()

    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCaptureSession()
        
        view.addSubview(capture)
        view.addSubview(dismiss)
        
        capture.anchors(top: nil, toppad: 0, bottom: view.bottomAnchor,
                        bottompad: 12, left: nil, leftpad: 0, right: nil,
                        rightpad: 0, height: 80, width: 80)
        capture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        dismiss.anchors(top: view.topAnchor, toppad: 12, bottom: nil, bottompad: 0,
                        left: view.leftAnchor, leftpad: 12, right: nil, rightpad: 0,
                        height: 50, width: 50)
    }
    
    fileprivate func configureCaptureSession() {
        let capture = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        // add input
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if (capture.canAddInput(input)) {
               capture.addInput(input)
            }
        } catch let err { print("Couldn't set up camera input:", err) }
        
        // add output
        let output = AVCapturePhotoOutput()
        if (capture.canAddOutput(output)) {
           capture.addOutput(output)
        }
        
        // add preview
        let preview = AVCaptureVideoPreviewLayer(session: capture)
            preview.frame = view.frame
        view.layer.addSublayer(preview)
        capture.startRunning()
    }
    
    @objc func capturePhoto() {
        
    }
    
    @objc func dismissCamera() {
        dismiss(animated: true, completion: nil)
    }
}
