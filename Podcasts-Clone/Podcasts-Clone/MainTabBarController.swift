//  MainTabBarController.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        
        viewControllers = [
            configureViewController(controller: UIViewController(),
                                    title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            configureViewController(controller: SearchController(),
                                    title: "Search", image: #imageLiteral(resourceName: "search")),
            configureViewController(controller: UIViewController(),
                                    title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
        selectedIndex = 1
    }
    
    fileprivate func configureViewController(controller: UIViewController,
                                             title: String,
                                             image: UIImage) -> UIViewController {
        controller.navigationItem.title = title
        controller.view.backgroundColor = .white
        let navigation = UINavigationController(rootViewController: controller)
            navigation.tabBarItem.title = title
            navigation.tabBarItem.image = image
            navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }
}
