// Created by Anthony Washington on 3/9/17.
// Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController,
                          UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout,
                          UISearchBarDelegate
{
    
    private var searchMode = false
    private var filterList = [Pokemon]()
    private var pokemonList = [Pokemon]()
    private var musicPlayer: AVAudioPlayer!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.collection.delegate = self
        self.collection.dataSource = self
        self.searchBar.returnKeyType = UIReturnKeyType.done
        self.searchBar.showsCancelButton = true
        
        
        self.parsePokemonCSV()
        self.init_audio()
    }
    
    
    func init_audio() {
        let path = Bundle.main.path(forResource: "music", ofType: ".mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError { print(err) }
    }

    // configure collection view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell {
        
            let pokemon: Pokemon!
            
            if searchMode { pokemon = filterList[indexPath.row] }
            else { pokemon = pokemonList[indexPath.row] }
            
            // adjust cell for allocated pokemon.
            cell.configureCell(pokemon)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemon: Pokemon!
        
        if searchMode { pokemon = filterList[indexPath.row] }
        else{ pokemon = pokemonList[indexPath.row] }
        
        
        performSegue(withIdentifier: "pokemonDetail", sender: pokemon)
    }
    
    // return number of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchMode { return filterList.count }
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
        } catch let err as NSError { print(err.debugDescription) }
    }

    // play/pause pokemon music
    @IBAction func musicButton(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            // pause music and make button transparent
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    
    // dismiss keyboard after search pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // dismiss keyboard after cancel pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // method for search through list
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        if searchBar.text == nil || searchBar.text == "" {
            self.searchMode = false
            // dismiss keyboard
            view.endEditing(true)
        }
        else {
            self.searchMode = true
            let text = searchBar.text!.lowercased()
            // filter list for items that contain search text.
            filterList = pokemonList.filter({$0.getPokeName().range(of: text) != nil })
        }
        collection.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetail" {
            if let destination = segue.destination as? DetailViewController {
                if let pokemon = sender as? Pokemon {
                    destination.setPokemon(pokemon: pokemon)
                }
            }
        }
    }
    
    
}

