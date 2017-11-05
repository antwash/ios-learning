//  SharePhotoController.swift
//  Instagram
//  Created by Anthony Washington on 11/5/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.image.image = selectedImage
        }
    }
    
    let container: UIView = {
        let c = UIView()
            c.backgroundColor = .white
        return c
    }()
    
    
    let image: UIImageView = {
        let i = UIImageView()
            i.clipsToBounds = true
            i.contentMode = .scaleAspectFill
        return i
    }()
    
    let text: UITextView = {
        let t = UITextView()
            t.font = UIFont.boldSystemFont(ofSize: 14)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.title = "Share"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style:
            .done, target: self, action: #selector(sharePhoto))
        configureShareContainer()
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    fileprivate func configureShareContainer() {
        view.addSubview(container)
        container.anchors(top: topLayoutGuide.bottomAnchor, toppad: 0, bottom: nil,
                          bottompad: 0, left: view.leftAnchor, leftpad: 0,
                          right: view.rightAnchor, rightpad: 0, height: 100, width: 0)
        
        container.addSubview(image)
        container.addSubview(text)
        
        image.anchors(top: container.topAnchor, toppad: 8, bottom: container.bottomAnchor,
                      bottompad: 8, left: container.leftAnchor, leftpad: 8, right: nil,
                      rightpad: 0, height: 0, width: 84)
        text.anchors(top: container.topAnchor, toppad: 8, bottom: container.bottomAnchor,
                     bottompad: 8, left: image.rightAnchor, leftpad: 8, right: container.rightAnchor,
                     rightpad: 8, height: 0, width: 0)
    }
    
    
    fileprivate func writeToDatabase(image_url: String) {
        guard let image = selectedImage else { return }
        guard let user = Auth.auth().currentUser?.uid else { return }
        guard let caption = text.text else { return }
        
        let userRef = Database.database().reference().child("posts").child(user)
        let ref = userRef.childByAutoId()
        
        let values = [ "image_url": image_url, "caption": caption,
            "width": image.size.width, "height": image.size.height,
            "creationDate": Date().timeIntervalSince1970
            ] as [String : Any]
        
        ref.updateChildValues(values) { (error, reference) in
            if let err = error {
                print("Error saving to DB:", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func sharePhoto() {
        guard let image = selectedImage else { return }
        guard let user = Auth.auth().currentUser?.uid else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(user).child(filename).putData(
        uploadData, metadata: nil) { (metadata, error) in
            if let err = error {
                print("Error uploading image:", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }

            guard let image_url = metadata?.downloadURL()?.absoluteString else { return }
            self.writeToDatabase(image_url: image_url)
        }
        
    }
}
