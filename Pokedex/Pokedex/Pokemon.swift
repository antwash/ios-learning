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

    fileprivate var id: Int!
    fileprivate var name: String!
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func getPokeId() -> Int { return id }
    func getPokeName() -> String { return name }
    
}
