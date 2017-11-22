//  UserSearchController.swift
//  Instagram
//  Created by Anthony Washington on 11/21/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class UserSearchController: UICollectionViewController {
    
    let cellId = "cellId"
    
    let searchBar: UISearchBar = {
        let s = UISearchBar()
            s.placeholder = "Search username"
            s.barTintColor = .gray
            UITextField.appearance(whenContainedInInstancesOf:
                [UISearchBar.self]).backgroundColor = UIColor.rgb(red:
                240, green: 240, blue: 240)
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
        navigationController?.navigationBar.addSubview(searchBar)
        
        let nav = navigationController?.navigationBar
        searchBar.anchors(top: nav?.topAnchor , toppad: 0, bottom: nav?.bottomAnchor,
                          bottompad: 0, left: nav?.leftAnchor, leftpad: 8,
                          right: nav?.rightAnchor, rightpad: 8, height: 0, width: 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as! UserSearchCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension UserSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
