//  HomeFeedController.swift
//  Instagram
//  Created by Anthony Washington on 11/6/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

class HomeFeedController : UICollectionViewController {
    
    let cellId = "cellId"
    
    lazy var refreshControl: UIRefreshControl = {
        let r = UIRefreshControl()
            r.addTarget(self, action: #selector(refreshHomeFeed), for: .valueChanged)
        return r
    }()
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllPost()
        configureNavigationBar()
        collectionView?.refreshControl = refreshControl
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeFeedCell.self,
                                 forCellWithReuseIdentifier: cellId)
        
        NotificationCenter.default.addObserver(self, selector:
            #selector(updateFeed), name: UPDATE_FEED, object: nil)
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
    
    fileprivate func fetchAllPost() {
        getCurrentUserTimeline()
        fetchFollowingUsersPost()
    }
    
    fileprivate func getCurrentUserTimeline() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.fetchUserWithId(uid: uid) { (user, error) in
            if let err = error {
                print("Failed to get user:", err)
                return
            }
            guard let user = user else { return }
            self.fetchUserPosts(user: user)
        }
    }
    
    fileprivate func fetchFollowingUsersPost() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("following").child(uid)
        ref.observe(.value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            dictionary.forEach({ (key, value) in
                Database.fetchUserWithId(uid: key, completion: { (user, error) in
                    if let err = error {
                        print("Error fetching user:", err)
                        return
                    }
                    guard let user = user else { return }
                    self.fetchUserPosts(user: user)
                })
            })
        }) { (error) in
            print("Error retreving following list:", error)
        }
    }

    fileprivate func fetchUserPosts(user: User) {
        let ref = Database.database().reference().child("posts").child(user.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let values = snapshot.value as? [String:Any] else { return }
            values.forEach({ (key, value) in
                guard let dictionary = value as? [String:Any] else { return }
                
                let post = Post(user: user, dictionary: dictionary)
                self.posts.append(post)
            })
            
            self.posts.sort(by: { (a, b) -> Bool in
                return a.creationDate.compare(b.creationDate) == .orderedDescending
            })
            
            self.collectionView?.refreshControl?.endRefreshing()
            self.collectionView?.reloadData()
        }) { (error) in
            print("Error to fetch photos:", error)
            return
        }
    }
    
    @objc func updateFeed() { refreshHomeFeed() }
    
    @objc func refreshHomeFeed() {
        posts.removeAll()
        fetchAllPost()
    }
}

extension HomeFeedController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 44 + 8 + 8 + view.frame.width + 40 + 40
        return CGSize(width: view.frame.width, height: height)
    }
}
