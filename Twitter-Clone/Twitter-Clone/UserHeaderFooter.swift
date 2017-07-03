//
//  Cell.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import LBTAComponents
let twitter = UIColor(r: 61, g: 167, b: 244)

// header cell
class UserHeader: DatasourceCell {
    let label: UILabel = {
        let l = UILabel()
            l.text = "WHO TO FOLLOW"
            l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(label)
        label.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor,
                     right: rightAnchor, topConstant: 0, leftConstant: 12,
                     bottomConstant: 0, rightConstant: 0, widthConstant: 0,
                     heightConstant: 0)
    }
}

//footer cell
class UserFooter: DatasourceCell {
    let label: UILabel = {
        let l = UILabel()
            l.text = "Show me more"
            l.font = UIFont.systemFont(ofSize: 15)
            l.textColor = twitter
        return l
    }()
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(label)
        label.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor,
                     right: rightAnchor, topConstant: 0, leftConstant: 12,
                     bottomConstant: 0, rightConstant: 0, widthConstant: 0,
                     heightConstant: 0)
    }
}
