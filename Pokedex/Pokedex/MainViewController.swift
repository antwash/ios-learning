//
//  MainViewController.swift
//  Pokedex
//
//  Created by Anthony Washington on 3/9/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class MainViewController:  UICollectionViewController, UICollectionViewDelegateFlowLayout{

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "PokeDex"
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
    }

}
