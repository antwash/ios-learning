//
//  ShareController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 7/11/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import Firebase

class ShareController: UIViewController {
    
    var selected:UIImage? {
        didSet {
            self.imageSharing.image = selected
        }
    }
    
    let imageSharing: UIImageView = {
        let i = UIImageView()
            i.clipsToBounds = true
            i.contentMode = .scaleAspectFill
        return i
    }()
    
    let caption: UITextView = {
        let c = UITextView()
            c.font = UIFont.systemFont(ofSize: 14)
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShareContainer()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(sharePhoto))
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    func sharePhoto() {
        guard let image = selected else { return }
        guard let data = UIImageJPEGRepresentation(image, 0.5) else { return }
        let fileName = NSUUID().uuidString
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        FIRStorage.storage().reference().child("posts").child(fileName).put(data, metadata: nil) { (metadata, error) in
            
            if let err = error {
                print("Failed to upload post: ", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            
            guard let imageURL = metadata?.downloadURL()?.absoluteString else {
                return }
            
            self.saveToDatabase(imageUrl: imageURL)
            print("Uploaded post successfully: ", imageURL)
        }
        
    }
    
    fileprivate func saveToDatabase(imageUrl: String) {
        guard let image = selected else { return }
        guard let caption = caption.text else { return }
        guard let id = FIRAuth.auth()?.currentUser?.uid else { return }
        
        let userPost = FIRDatabase.database().reference().child("posts").child(id)
        let ref = userPost.childByAutoId()
        let value = ["imageURL": imageUrl, "caption": caption,
                     "imageWidth": image.size.width,
                     "imageHeight": image.size.height,
                     "createdData": Date.timeIntervalSinceReferenceDate] as [String : Any]
        
        ref.updateChildValues(value) { (error, ref) in
            if let error = error {
                print("Failed to save post to database: ", error)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("Successfully saved post to database.")
            self.dismiss(animated: true, completion: nil)
        }
    
    
    }
    
    fileprivate func addShareContainer() {
        let shareContainer = UIView()
            shareContainer.backgroundColor = .white
        
        view.addSubview(shareContainer)
        shareContainer.addSubview(imageSharing)
        shareContainer.addSubview(caption)
        
        shareContainer.anchors(top: topLayoutGuide.bottomAnchor, topPad: 0, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 100, width: 0)
        
        imageSharing.anchors(top: shareContainer.topAnchor, topPad: 8, bottom: shareContainer.bottomAnchor, bottomPad: 8, left: shareContainer.leftAnchor, leftPad: 8, right: nil, rightPad: 0, height: 0, width: 84)
        
        caption.anchors(top: shareContainer.topAnchor, topPad: 8, bottom: shareContainer.bottomAnchor, bottomPad: 8, left: imageSharing.rightAnchor, leftPad: 8, right: shareContainer.rightAnchor, rightPad: 8, height: 0, width: 0)
    }
}
