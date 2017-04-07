// Created by Anthony Washington on 4/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvolveImage: UIImageView!
    @IBOutlet weak var nextEvolveImage: UIImageView!
    @IBOutlet weak var evolveLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLabel.text = "\(pokemon.getId())"
        nameLabel.text = pokemon.getName().capitalized
        mainImage.image = UIImage(named: "\(pokemon.getId())")
        currentEvolveImage.image = UIImage(named: "\(pokemon.getId())")
        
        pokemon.getPokemonDetails {
            // action performed after HTTP request if finish
            self.updateUserInterface()
        }
    }
    

    func setPokemon(pokemon: Pokemon){
        self.pokemon = pokemon
    }
    
    func updateUserInterface() {
        typeLabel.text = pokemon.getType()
        attackLabel.text = pokemon.getAttack()
        heightLabel.text = pokemon.getHeight()
        weightLabel.text = pokemon.getWeight()
        defenseLabel.text = pokemon.getDefense()
    }
    

    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
