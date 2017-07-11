//
//  MainTabController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 5/1/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth()?.currentUser == nil {
            DispatchQueue.main.async {
                let login = LoginController()
                let navController = UINavigationController(rootViewController: login)
              self.present(navController, animated: true, completion: nil)
            }
            return
        }
 
        let layout = UICollectionViewFlowLayout()
        let userProfile = UserProfileController(collectionViewLayout: layout)
        let navagation = UINavigationController(rootViewController: userProfile)
            navagation.tabBarItem.image = UIImage(named: "user_unselected")
            navagation.tabBarItem.selectedImage = UIImage(named: "user_selected")
        
        tabBar.tintColor = UIColor.black

        viewControllers = [navagation]
    }
}
