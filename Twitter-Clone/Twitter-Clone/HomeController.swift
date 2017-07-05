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
        if indexPath.section == 0 {
            guard let user = self.datasource?.item(indexPath) as? User else { return .zero }
                // get text size to figure out amout of space needed for cell
                let estimate = estimateHeight(user.bioText)
                // add height of each component - username/name/padding
                return CGSize(width: view.frame.width, height: estimate + 65)
        }
        else if indexPath.section == 1 {
            guard let tweet = self.datasource?.item(indexPath) as? Tweet else { return .zero }
                let estimate = estimateHeight(tweet.message)
                // add height of each component - username/name/padding
                return CGSize(width: view.frame.width, height: estimate + 65)
        }

        return CGSize(width: view.frame.width, height: 150)
    }
    
    
    // calls cell resizing when device rotates
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func estimateHeight(_ text: String) -> CGFloat {
        let width = view.frame.width - 12 - 50 - 12 - 2
        let size = CGSize(width: width, height: 1000)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]
        let estimate = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimate.height
    }
}

