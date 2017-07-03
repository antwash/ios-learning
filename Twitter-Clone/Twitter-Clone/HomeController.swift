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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    // cell size
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // get user from row
        if let user = self.datasource?.item(indexPath) as? User {
            
            // 12, 50 - comes from profile image constraints
            let width = view.frame.width  - 12 - 50 - 12 - 2
            let size = CGSize(width: width, height: 1000)
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
            
            // get text size to figure out amout of space needed for cell
            let estimate = NSString(string: user.bioText).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            // add height of each component - username/name/padding
            return CGSize(width: view.frame.width, height: estimate.height + 65)
        }
        
        return CGSize(width: view.frame.width, height: 150)
    }
    
    
    
}

