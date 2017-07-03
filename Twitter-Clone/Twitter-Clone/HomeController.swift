//
//  HomeDataSouceController.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import LBTAComponents

class HomeController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = HomeDataSource()
    }
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    // footer size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    
    
}

