//  PreviewPhotoView.swift
//  Instagram
//  Created by Anthony Washington on 11/26/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Photos

class PreviewPhotoView: UIView {
    
    lazy var save_alert: UILabel = {
        let s = UILabel()
            s.numberOfLines = 0
            s.textColor = .white
            s.textAlignment = .center
            s.font = UIFont.boldSystemFont(ofSize: 18)
            s.backgroundColor = UIColor(white: 0, alpha: 0.3)
            s.layer.transform = CATransform3DMakeScale(0, 0, 0)
            s.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
            s.center = self.center
        return s
    }()
    
    let save: UIButton = {
        let s = UIButton(type: .system)
            s.setImage(#imageLiteral(resourceName: "save_shadow"), for: .normal)
            s.addTarget(self, action: #selector(savePreviewPhoto), for: .touchUpInside)
        return s
    }()
    
    let dismiss: UIButton = {
        let d = UIButton(type: .system)
            d.setImage(#imageLiteral(resourceName: "cancel_shadow"), for: .normal)
            d.addTarget(self, action: #selector(dismissPreview), for: .touchUpInside)
        return d
    }()
    
    let previewImage: UIImageView = {
        let p = UIImageView()
        return p
    }()
    
    @objc func dismissPreview() { self.removeFromSuperview() }
    
    @objc func savePreviewPhoto() {
        guard let image = self.previewImage.image else { return }
        
        let library = PHPhotoLibrary.shared()
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { (success, error) in
            var message = ""
            if let _ = error { message = "Error saving image" }
            else { message = "Saved image successfully" }
            
            DispatchQueue.main.async {
                self.save_alert.text = message
                self.addSubview(self.save_alert)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.save_alert.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (completed) in
                    
                    UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                                    
                        self.save_alert.alpha = 0
                        self.save_alert.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                    }, completion: { (_) in self.save_alert.removeFromSuperview() })
                })
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewImage)
        addSubview(dismiss)
        addSubview(save)
        
        previewImage.anchors(top: topAnchor, toppad: 0, bottom: bottomAnchor,
                             bottompad: 0, left: leftAnchor, leftpad: 0,
                             right: rightAnchor, rightpad: 0, height: 0, width: 0)
        
        dismiss.anchors(top: topAnchor, toppad: 12, bottom: nil, bottompad: 0,
                        left: leftAnchor, leftpad: 12, right: nil, rightpad: 0,
                        height: 50, width: 50)
        
        save.anchors(top: nil, toppad: 0, bottom: bottomAnchor, bottompad: 12,
                     left: leftAnchor, leftpad: 12, right: nil, rightpad: 0,
                     height: 50, width: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
