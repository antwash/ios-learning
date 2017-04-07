//
//  PokeCell.swift
//  Pokedex
//
//  Created by Anthony Washington on 4/3/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    fileprivate var pokemon: Pokemon!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    
    
    // Update pokemon cell
    func configureCell(_ pokemon: Pokemon){
        self.pokemon = pokemon
        self.nameLabel.text = self.pokemon.getName().capitalized
        self.thumbImage.image = UIImage(named: "\(self.pokemon.getId())")
    }
}
