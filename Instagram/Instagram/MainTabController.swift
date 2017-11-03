//  MainTabController.swift
//  Instagram
//  Created by Anthony Washington on 11/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.


import UIKit
import Firebase

class MainTabController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navigation = UINavigationController(rootViewController: LoginController())
                self.present(navigation, animated: true, completion: nil)
                return
            }
        }
        configureUserProfile()
    }
    
    func configureUserProfile() {
        let profile = UINavigationController(rootViewController:
            ProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
            profile.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
            profile.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        viewControllers = [profile]
    }
}
