//
//  MainViewController.swift
//  Pokedex
//
//  Created by Anthony Washington on 3/9/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class MainViewController:  UICollectionViewController, UICollectionViewDelegateFlowLayout{

    let cellId = "pokeCell"
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = UIImageView(image: UIImage(named: "bg"))
            background.contentMode = .scaleAspectFill
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for Pokemon"
        
        navigationItem.titleView = searchBar
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundView = background
        collectionView?.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    // sets the width and height of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

}
