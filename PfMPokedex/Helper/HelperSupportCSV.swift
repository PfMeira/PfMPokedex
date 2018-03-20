//
//  HelperSupportCSV.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 13/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class HelperSupportCSV {
    
    static func parsePokemonCSV() -> [Pokemon] {
        
        var pokemons = [Pokemon]()
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let cvs = try CSV(contentsOfURL: path)
            let rows = cvs.rows
            
            for row in rows {
                guard let id = row["id"], let name = row["identifier"] else {
                    return []
                }
                let pokemon = Pokemon(name: name, identifier: id)
                pokemons.append(pokemon)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        return pokemons
    }
}
