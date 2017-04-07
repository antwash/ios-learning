// Created by Anthony Washington on 4/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.getPokeName()
    }
    
    func setPokemon(pokemon: Pokemon){
        self.pokemon = pokemon
    }

}
