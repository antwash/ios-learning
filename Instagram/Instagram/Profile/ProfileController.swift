//  ProfileController.swift
//  Instagram
//  Created by Anthony Washington on 11/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

struct User {
    let username: String
    let image_url : String
    
    init(dic: [String: String]) {
        self.username = dic["username"] ?? ""
        self.image_url = dic["profile_url"] ?? ""
    }
}

class ProfileController : UICollectionViewController {

    let cellId = "cellId"
    let headerId = "headerId"
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(UICollectionViewCell.self,
                                 forCellWithReuseIdentifier: cellId)
        collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style: .plain,
                                                            target: self, action: #selector(userLogOut))
        getCurrentUser()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
            header.user = currentUser
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .red
        return cell
    }
    
    @objc func userLogOut() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "LogOut", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let nav = UINavigationController(rootViewController: LoginController())
                self.present(nav, animated: true, completion: nil)
            } catch let err { print("Signout error:", err) }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func getCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(uid).observeSingleEvent(
            of: .value, with: { (snapshot) in
                guard let values = snapshot.value as? [String: String] else { return }
                self.currentUser = User(dic: values)
                self.navigationItem.title = self.currentUser?.username
                self.collectionView?.reloadData()
        }) { (error) in
            print("Failed to get user:", error)
        }
    }
}

extension ProfileController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - 2) / 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
