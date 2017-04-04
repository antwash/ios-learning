// Created by Anthony Washington on 3/9/17.
// Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,
                          UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout
{
    
    private var pokemonList = [Pokemon]()
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collection.delegate = self
        self.collection.dataSource = self
        self.parsePokemonCSV()
    }
    

    // configure collection view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell {
        
            let pokemon = pokemonList[indexPath.row]
            
            // adjust cell for allocated pokemon.
            cell.configureCell(pokemon)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // return number of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList.count
    }

    // return number of sections in collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // return size of individual cell.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    // parses Pokemon CSV File for data.
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let id = Int(row["id"]!)
                let name = row["identifier"]!
        
                self.pokemonList.append(Pokemon(id: id!, name: name))
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }


}
