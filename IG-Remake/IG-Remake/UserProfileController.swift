//
//  UserProfileController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 5/1/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController,
UICollectionViewDelegateFlowLayout {
    
    var user: User?
    let cellID = "imageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(UserProfileHeader.self,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                 withReuseIdentifier: "header")
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        getUser()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "header",
                                                                     for: indexPath) as!UserProfileHeader
        
        header.user_profile = self.user
        
        return header
    }
    
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
            cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // image cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (view.frame.width - 2) / 3
        return CGSize(width: size, height: size)
    }
    

    fileprivate func getUser() {
        guard let uuid = FIRAuth.auth()?.currentUser?.uid  else { return }
        
        FIRDatabase.database().reference().child("users").child(uuid).observe(.value, with: { (snapshot) in
            guard let values = snapshot.value as? [String: Any] else { return }
            
            self.user = User(dictionary: values)
            self.navigationItem.title = self.user?.userName
            self.collectionView?.reloadData()
            
        }) { (error) in
            print("Faild to fetch user: ", error)
        }
    }
}
