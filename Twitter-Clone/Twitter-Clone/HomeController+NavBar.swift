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
        
        // remove default line from nav bar add custom view
        let navbarseperator = UIView()
            navbarseperator.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        view.addSubview(navbarseperator)
        navbarseperator.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil,
                               right: view.rightAnchor, topConstant: 0, leftConstant: 0,
                               bottomConstant: 0, rightConstant: 0, widthConstant: 0,
                               heightConstant: 0.5)
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
