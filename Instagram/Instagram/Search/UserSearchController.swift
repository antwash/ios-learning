//  UserSearchController.swift
//  Instagram
//  Created by Anthony Washington on 11/21/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

class UserSearchController: UICollectionViewController {
    
    let cellId = "cellId"
    var users: [User] = []
    var filtered: [User] = []
    
    lazy var searchBar: UISearchBar = {
        let s = UISearchBar()
            s.delegate = self
            s.placeholder = "Search username"
            s.autocapitalizationType = .none
            s.barTintColor = .gray
            UITextField.appearance(whenContainedInInstancesOf:
                [UISearchBar.self]).backgroundColor = UIColor.rgb(red:
                240, green: 240, blue: 240)
        
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUsers()
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .onDrag
        collectionView?.register(UserSearchCell.self, forCellWithReuseIdentifier: cellId)
        navigationController?.navigationBar.addSubview(searchBar)
        
        let nav = navigationController?.navigationBar
        searchBar.anchors(top: nav?.topAnchor , toppad: 0, bottom: nav?.bottomAnchor,
                          bottompad: 0, left: nav?.leftAnchor, leftpad: 8,
                          right: nav?.rightAnchor, rightpad: 8, height: 0, width: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as! UserSearchCell
            cell.user = filtered[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return filtered.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchBar.isHidden = true
        searchBar.resignFirstResponder()
        
        let user = filtered[indexPath.item]
        let detailPage = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
            detailPage.userId = user.uid
        navigationController?.pushViewController(detailPage, animated: true)
    }
    
    
    fileprivate func fetchUsers() {
        let myself = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("users")
        ref.observe(.value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            dictionary.forEach({ (key, value) in
                guard let user_values = value as? [String: String] else { return }
                
                if (key != myself) {
                    let user = User(uid: key, dic: user_values)
                    self.users.append(user)
                }
            })
            
            self.users.sort(by: { (a, b) -> Bool in
                return a.username.compare(b.username) == .orderedAscending
            })
            
            self.filtered = self.users
            self.collectionView?.reloadData()
        }) { (error) in
            print("Error fetching users:", error)
        }
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

extension UserSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            filtered = users
        } else {
            self.filtered = self.users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
        self.collectionView?.reloadData()
    }
}
