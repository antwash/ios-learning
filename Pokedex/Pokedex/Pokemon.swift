//  Created by Anthony Washington on 3/10/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

/*
 Pokemon Model class.
 @attributes :
 - id : Pokemon unique identifer.
 - name : Pokemon name.
 
 */
import Alamofire
import Foundation

class Pokemon {
    
    private var url: String!
    private var id: Int!
    private var name: String!
    private var description: String!
    private var type: String!
    private var defense: String!
    private var height: String!
    private var weight: String!
    private var attack: String!
    private var nextEvolve: String!
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.url = "\(URL_BASE)\(URL_POKEMON)\(self.id!)/"
    }
    
    // Getter method.
    func getId() -> Int { return id }
    func getURL() -> String { return url }
    func getName() -> String { return name }
    func getType() -> String { return type == nil ? "" : type}
    func getHeight() -> String { return height == nil ? "" : height }
    func getWeight() -> String { return weight == nil ? "" : weight }
    func getAttack() -> String { return attack == nil ? "" : attack }
    func getDefense() -> String { return defense == nil ? "" : defense}
    func getDesc() -> String { return description == nil ? "" : description }
    func getNextEvolve() -> String { return nextEvolve == nil ? "" : nextEvolve }
    
    
    // get Pokemon details
    // use custom closure to notify Controller when
    // Pokemon data is finished dowloading -- ready
    // to update UIVIEW.
    func getPokemonDetails(completed: @escaping DownloadComplete) {
        // GET by default
        Alamofire.request(self.url).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String { self.weight = weight }
                if let height = dict["height"] as? String { self.height = height }
                if let attack = dict["attack"] as? Int { self.attack = "\(attack)" }
                if let defense = dict["defense"] as? Int { self.defense = "\(defense)" }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] { self.type = name.capitalized }
                    
                    // if more types
                    if types.count > 1 {
                        for t in 1..<types.count {
                           if let name = types[t]["name"] {
                                // add additional name to type.
                                if self.type.range(of: name) == nil { self.type! += "/\(name.capitalized)" }
                            }
                        }
                    }
                }
            
            }
            completed()
        }
    }
}
