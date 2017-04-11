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
    private var nextEvolveID: String!
    private var nextEvolveName: String!
    private var nextEvolveLevel: String!
    
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
    func getNextEvolveID() -> String { return nextEvolveID == nil ? "" : nextEvolveID }
    func getNextEvolveName() -> String { return nextEvolveName == nil ? "" : nextEvolveName }
    func getNextEvolveLevel() -> String { return nextEvolveLevel == nil ? "" : nextEvolveLevel! }
    
    // get Pokemon details
    // use custom closure to notify Controller when
    // Pokemon data is finished dowloading -- ready
    // to update UIVIEW.
    func getPokemonDetails(completed: @escaping DownloadComplete) {
        // GET by default
        Alamofire.request(self.url).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String { self.weight = weight }
                if let height = dict["height"] as? String { self.height = height }
                if let attack = dict["attack"] as? Int { self.attack = "\(attack)" }
                if let defense = dict["defense"] as? Int { self.defense = "\(defense)" }
                
                // types
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
                }// types
                
                // description
                if let desc_array = dict["descriptions"] as? [Dictionary<String, String>] , desc_array.count > 0 {
                    if let url = desc_array[0]["resource_uri"] {
                        Alamofire.request("\(URL_BASE)\(url)").responseJSON(completionHandler: { (response) in
                            if let descript = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descript["description"] as? String {
                                    self.description = description
                                }
                            }
                            completed()
                        })
                    }
                }// description
                
                
                // evolutions
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    if let next = evolutions[0]["to"] as? String {
                        if next.range(of: "mega") == nil {
                            self.nextEvolveName = next
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let id = uri.replacingOccurrences(of: "/api/v1/pokemon", with: "")
                                self.nextEvolveID = id.replacingOccurrences(of: "/", with: "")
                                
                                if let lvl = evolutions[0]["level"] {
                                    if let level = lvl as? Int { self.nextEvolveLevel = "\(level)" }
                                }// next level
                            }// next id
                        }
                    }
                }// evolutions
            }//dict
            completed()
        }
    }
}
