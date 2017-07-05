//
//  HomeDataSouceController.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import LBTAComponents
import TRON

class HomeController: DatasourceController {
    
    let errorMessage: UILabel = {
        let l = UILabel()
            l.text = "Sorry, something went wrong. Please try again later."
            l.numberOfLines = 0
            l.isHidden = true
            l.textAlignment = .center
        return l
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(errorMessage)
        errorMessage.fillSuperview()
        
        setupNavigationBar()
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        // fetched data using custom completion hander / singleton pattern object
        Service.sharedInstance.fetchData { (dataSource, err) in
            if let err = err {
                self.errorMessage.isHidden = false
                if let apiError = err as? APIError<jSONError> {
                    if apiError.response?.statusCode != 200 {
                        self.errorMessage.text = "Error 404: Opps something went wrong!"
                    }
                }
                return
            }
            self.datasource = dataSource
        }
    }
    
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 { return .zero }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    // footer size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == 1 { return .zero }
        return CGSize(width: view.frame.width, height: 64)
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
        
        if let user = self.datasource?.item(indexPath) as? Tweet {
            let width = view.frame.width - 12 - 50 - 12 - 2
            let size = CGSize(width: width, height: 1000)
            let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
            
            // get text size to figure out amout of space needed for cell
            let estimate = NSString(string: user.message).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            // add height of each component - username/name/padding
            return CGSize(width: view.frame.width, height: estimate.height + 65)
        }
        print("HGEY")
        return CGSize(width: view.frame.width, height: 150)
    }
    
    
    // calls cell resizing when device rotates
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
}

