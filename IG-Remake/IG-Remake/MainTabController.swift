//
//  MainTabController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 5/1/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController, UITabBarControllerDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if FIRAuth.auth()?.currentUser == nil {
            DispatchQueue.main.async {
                let login = LoginController()
                let navController = UINavigationController(rootViewController: login)
              self.present(navController, animated: true, completion: nil)
            }
            return
        }
 
        setupViewControllers()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            
            let navController = UINavigationController(rootViewController: PhototSelectController(collectionViewLayout: UICollectionViewFlowLayout()))
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func setupViewControllers() {
        let homeController = addController(viewcontroller: UIViewController(), selected: #imageLiteral(resourceName: "home_selected"),
                                           unselected: #imageLiteral(resourceName: "home_unselected"))
        
        let searchController = addController(viewcontroller: UIViewController(), selected: #imageLiteral(resourceName: "search_selected"),
                                             unselected: #imageLiteral(resourceName: "search_unselected"))
        
        let photoController = addController(viewcontroller: UIViewController(), selected: nil,
                                            unselected: #imageLiteral(resourceName: "plus_unselected"))
        
        let likeController = addController(viewcontroller: UIViewController(), selected: #imageLiteral(resourceName: "like_selected"),
                                           unselected: #imageLiteral(resourceName: "like_unselected"))
    
        let userController = addController(viewcontroller: UserProfileController(collectionViewLayout:
            UICollectionViewFlowLayout()), selected: #imageLiteral(resourceName: "user_selected"),
                                           unselected: #imageLiteral(resourceName: "user_unselected"))
        
        
        tabBar.tintColor = UIColor.black
        
        viewControllers = [homeController, searchController,
                           photoController, likeController, userController]
        
        guard let items = tabBar.items else {return}
        
        // center tab bar icons
        for i in items {
            i.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    func addController(viewcontroller: UIViewController,
                       selected: UIImage?, unselected: UIImage) -> UINavigationController {
        let navagation = UINavigationController(rootViewController: viewcontroller)
            navagation.tabBarItem.image = unselected
            navagation.tabBarItem.selectedImage = selected
        return navagation
    }
}
