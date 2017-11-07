//  HomeFeedController.swift
//  Instagram
//  Created by Anthony Washington on 11/6/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

class HomeFeedController : UICollectionViewController {
    
    let cellId = "cellId"
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentUserPosts()
        configureNavigationBar()
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeFeedCell.self,
                                 forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            cellId, for: indexPath) as! HomeFeedCell
            cell.post = posts[indexPath.item]
        
        return cell
    }
    
    
    fileprivate func configureNavigationBar() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    fileprivate func getCurrentUserPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let values = snapshot.value as? [String:Any] else { return }
            values.forEach({ (key, value) in
                guard let dictionary = value as? [String:Any] else { return }
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
            })
            self.collectionView?.reloadData()
        }) { (error) in
            print("Error to fetch photos:", error)
            return
        }
    }
}

extension HomeFeedController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
