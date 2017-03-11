//
//  Pokemon.swift
//  Pokedex
//
//  Created by Anthony Washington on 3/10/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import Foundation

class Pokemon {

    private var id: Int!
    private var name: String!
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func getId() -> Int { return id }
    func getName() -> String { return name }
    

}
