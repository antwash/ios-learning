//
//  PokemonAnnotation.swift
//  PokeFinder
//
//  Created by Anthony Washington on 4/21/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import Foundation


class PokemonAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokeId: Int
    
    init(coordinate: CLLocationCoordinate2D, id: Int){
        self.coordinate = coordinate
        self.pokeId = id
    }





}
