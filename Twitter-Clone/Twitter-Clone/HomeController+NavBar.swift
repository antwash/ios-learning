//
//  HomeController+NavBar.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/3/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

// Home Controller Nav bar setup extension
extension HomeController {

    func setupNavigationBar() {
        setupLeftSide()
        setupRightSide()
        setupOther()
    }
    
    // setup remaining of home navigation bar
    private func setupOther() {
        let title = UIImageView(image: #imageLiteral(resourceName: "title_icon"))
            title.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            title.contentMode = .scaleAspectFit
        navigationItem.titleView = title
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // setup left side of home navigation bar
    private func setupLeftSide() {
        let follow = UIButton(type: .system)
            follow.setImage(#imageLiteral(resourceName: "follow").withRenderingMode(.alwaysOriginal), for: .normal)
            follow.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: follow)
    }
    
    // setup right side of home navigation bar
    private func setupRightSide() {
        let search = UIButton(type: .system)
            search.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
            search.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let compose = UIButton(type: .system)
            compose.setImage(#imageLiteral(resourceName: "compose").withRenderingMode(.alwaysOriginal), for: .normal)
            compose.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.setRightBarButtonItems([UIBarButtonItem(customView: compose),
                                               UIBarButtonItem(customView: search)], animated: true)
    }


}
