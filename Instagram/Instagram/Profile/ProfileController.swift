//  ProfileController.swift
//  Instagram
//  Created by Anthony Washington on 11/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

class ProfileController : UICollectionViewController {

    let cellId = "cellId"
    let headerId = "headerId"
    
    var userId: String?
    var posts: [Post] = []
    var currentUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(ProfileImageCell.self,
                                 forCellWithReuseIdentifier: cellId)
        collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
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
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            cellId, for: indexPath) as! ProfileImageCell
            cell.post = posts[indexPath.item]
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
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        
        if (uid == Auth.auth().currentUser?.uid) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style:
                .plain, target: self, action: #selector(userLogOut))
        }
        
        Database.fetchUserWithId(uid: uid) { (user, error) in
            if let err = error {
                print("Failed fetching user:", err)
                return
            }
            
            guard let user = user else { return }
            self.currentUser = user
            self.collectionView?.reloadData()
            self.getCurrentUserOrderedPosts()
        }
    }

    fileprivate func getCurrentUserOrderedPosts() {
        guard let uid = currentUser?.uid else { return }
        let ref = Database.database().reference().child("posts").child(uid)
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let values = snapshot.value as? [String:Any] else { return }
            
            guard let user = self.currentUser else { return }
            let post = Post(user: user, dictionary: values)
            
            self.posts.insert(post, at: 0)
            self.collectionView?.reloadData()
        }) { (error) in
            print("Failed fetching post:", error)
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
