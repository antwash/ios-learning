//
//  UserProfileController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 5/1/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        getUser()
    }
    
    
    fileprivate func getUser() {
        guard let uuid = FIRAuth.auth()?.currentUser?.uid  else { return }
        FIRDatabase.database().reference().child("users").child(uuid).observe(.value, with: { (snapshot) in
            guard let values = snapshot.value as? [String: Any] else { return }
            let username = values["user_name"] as? String
            self.navigationItem.title = username
        }) { (error) in
            print("Faild to fetch user: ", error)
        }
    }
}
