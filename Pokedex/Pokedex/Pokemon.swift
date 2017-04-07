//  Created by Anthony Washington on 3/10/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

/*
 Pokemon Model class.
 @attributes :
 - id : Pokemon unique identifer.
 - name : Pokemon name.
 
 */

import Foundation

class Pokemon {

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
    }
    
    func getPokeId() -> Int { return id }
    func getPokeName() -> String { return name }
    
}
