//  TabBarController.swift
//  Podcast
//  Created by Anthony Washington on 6/9/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let podcastsController = PodcastsController()
        let favoritesController = FavoritesController()
        let downloadsController = UIViewController()
        
        viewControllers = [
            setupController(tabName: "Favorites",
                            tabImage: #imageLiteral(resourceName: "favorites"),
                            controller: favoritesController),
            setupController(tabName: "Search",
                            tabImage: #imageLiteral(resourceName: "search"),
                            controller: podcastsController),
            setupController(tabName: "Downloads",
                            tabImage: #imageLiteral(resourceName: "downloads"),
                            controller: downloadsController)
        ]
        
        selectedIndex = 1
        tabBar.tintColor = .purple
    }
    
    
    fileprivate func setupController(tabName: String,
                                     tabImage: UIImage,
                                     controller: UIViewController) -> UIViewController {
        controller.title = tabName
        controller.view.backgroundColor = .white
        let navController = UINavigationController(rootViewController: controller)
            navController.tabBarItem.title = tabName
            navController.tabBarItem.image = tabImage
            navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
