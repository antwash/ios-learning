//  MainTabController.swift
//  Instagram
//  Created by Anthony Washington on 11/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.


import UIKit
import Firebase

class MainTabController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let navigation = UINavigationController(rootViewController: LoginController())
                self.present(navigation, animated: true, completion: nil)
                return
            }
        }
        configureUserProfile()
    }
    
    fileprivate func setUpTabController(unselected: UIImage, selected: UIImage?,
                            controller: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: controller)
            nav.tabBarItem.image = unselected
            nav.tabBarItem.selectedImage = selected
        return nav
    }
    
    func configureUserProfile() {
        let home = setUpTabController(unselected: #imageLiteral(resourceName: "home_unselected"), selected: #imageLiteral(resourceName: "home_selected"), controller: UIViewController())
        let search = setUpTabController(unselected: #imageLiteral(resourceName: "search_unselected"), selected: #imageLiteral(resourceName: "search_selected"), controller: UIViewController())
        let profile = setUpTabController(unselected: #imageLiteral(resourceName: "profile_unselected"), selected: #imageLiteral(resourceName: "profile_selected"),
                                         controller: ProfileController(collectionViewLayout:
                                            UICollectionViewFlowLayout()))
        let camera = setUpTabController(unselected: #imageLiteral(resourceName: "plus_unselected"), selected: nil, controller: UIViewController())
        let like = setUpTabController(unselected: #imageLiteral(resourceName: "like_unselected"), selected: #imageLiteral(resourceName: "like_selected"), controller: UIViewController())
        
        tabBar.tintColor = .black
        viewControllers = [home, search, camera, like, profile]
        
        guard let views = tabBar.items else { return }
        for view in views {
            view.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}

extension MainTabController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 2 {
            let postphoto = UINavigationController(rootViewController:
                PostPhotoController(collectionViewLayout:UICollectionViewFlowLayout()))
            present(postphoto, animated: true, completion: nil)
            return false
        }
        return true
    }
}
