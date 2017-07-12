//
//  PhotoSelectController.swift
//  IG-Remake
//
//  Created by Anthony Washington on 7/11/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import Photos


class PhototSelectController: UICollectionViewController,
UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    var images = [UIImage]()
    var assests = [PHAsset]()
    var selectedImage: UIImage?
    var headerCopy: PhotoSelectionHeader?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotos()
        setupNavButtons()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PhotoSelectCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PhotoSelectionHeader.self, forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectCell
            cell.image.image = images[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
        self.collectionView?.reloadData()
        
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoSelectionHeader
        
        self.headerCopy = header
        
        if let selected = selectedImage {
            if let index = images.index(of: selected) {
                let selectedAssest = assests[index]
                let targetSize = CGSize(width: 600, height: 600)
                let imageManager = PHImageManager.default()
                    imageManager.requestImage(for: selectedAssest, targetSize: targetSize, contentMode: .default, options: nil, resultHandler: { (image, info) in
                        
                          header.image.image = image
                    })
                }
            }
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1, 0, 1, 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 1 }

    fileprivate func setupNavButtons() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(posting))
    }
    
    fileprivate func fetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                            ascending: false)]
        return fetchOptions
    }
    
    fileprivate func getPhotos() {
        let photos = PHAsset.fetchAssets(with: .image, options: fetchOptions())
        
        DispatchQueue.global(qos: .background).async {
            photos.enumerateObjects({ (assest, count, stop) in
                
            let targerSize = CGSize(width: 200, height: 200)
            let options = PHImageRequestOptions()
                options.isSynchronous = true
            let imageManager = PHImageManager()
                imageManager.requestImage(for: assest, targetSize: targerSize,
                    contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    guard let image = image else { return }
                    self.images.append(image)
                    self.assests.append(assest)
                
                    if self.selectedImage == nil {
                        self.selectedImage = image
                    }
                    
                    if count == photos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                })
            })
        }
    }
    
    
    func posting() {
        let share = ShareController()
            share.selected = headerCopy?.image.image
        navigationController?.pushViewController(share, animated: true)
    }
    
    
    func cancel() { dismiss(animated: true, completion: nil) }
    override var prefersStatusBarHidden: Bool { return true }
    
    
}
