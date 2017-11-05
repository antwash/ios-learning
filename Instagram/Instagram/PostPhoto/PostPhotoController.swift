//  PostPhotoController.swift
//  Instagram
//  Created by Anthony Washington on 11/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Photos

class PostPhotoController: UICollectionViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    var images: [UIImage] = []
    var assets: [PHAsset] = []
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PostPhotoCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PostPhotoCell.self, forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchUserPhotos()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath) as! PostPhotoCell
            cell.photo.image = images[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind
        kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind:
            kind, withReuseIdentifier: headerId, for: indexPath) as! PostPhotoCell
        
        if let select = selectedImage {
            if let index = images.index(of: select) {
                let selectedAsset = assets[index]
                let size = CGSize(width: 600, height: 600)
                let imageManager = PHImageManager.default()
                    imageManager.requestImage(for: selectedAsset, targetSize: size, contentMode:
                        .aspectFit, options: nil, resultHandler: { (image, information) in
                    header.photo.image = image
                })
            }
        }
        return header
    }
    
    fileprivate func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(share))
    }
    
    fileprivate func fetchUserPhotos() {
        let photos = PHAsset.fetchAssets(with: .image, options: setFetchOptions())
        DispatchQueue.global(qos: .background).async {
            photos.enumerateObjects { (asset, count, stop) in
                let size = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                    options.isSynchronous = true
                
                let manager = PHImageManager()
                    manager.requestImage(for: asset, targetSize: size, contentMode:
                    .aspectFit, options: options, resultHandler: { (image, information) in
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                        
                        if self.selectedImage == nil {
                            self.selectedImage = image
                        }
                    }
                    if count == self.images.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    fileprivate func setFetchOptions() -> PHFetchOptions {
        let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key:
                "creationDate", ascending: false)]
        return options
    }
    
    @objc func cancel() { dismiss(animated: true, completion: nil) }
    
    @objc func share() {
       print("SHARE")
    }
}

extension PostPhotoController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, minimumLineSpacingForSectionAt
        section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, minimumInteritemSpacingForSectionAt
        section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
}
