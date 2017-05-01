//
//  MainTabController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 5/1/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let layout = UICollectionViewFlowLayout()
        let userProfile = UserProfileController(collectionViewLayout: layout)
        let navagation = UINavigationController(rootViewController: userProfile)
            navagation.tabBarItem.image = UIImage(named: "user_unselected")
            navagation.tabBarItem.selectedImage = UIImage(named: "user_selected")
        
        tabBar.tintColor = UIColor.black

        viewControllers = [navagation]
    }
}
