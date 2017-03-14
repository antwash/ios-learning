//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Anthony Washington on 3/13/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let image: UIImageView = {
        let i = UIImageView()
            i.image = UIImage(named: "4")
            i.contentMode = .scaleAspectFit
            i.frame = CGRect(x: 0, y: 0, width: 50, height: 80)
            i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    func setupView(){
        self.backgroundColor = .blue
        
        addSubview(image)
        
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        
    }
}
