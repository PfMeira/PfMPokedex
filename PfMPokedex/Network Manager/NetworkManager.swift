//
//  NetworkManager.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 03/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    let getPokemons = NSURL(string: "http://pokeapi.co/api/v2/pokemon")
    
    func fetchPokemons(idPokemon: String, completion: @escaping () -> Void) {
        
        Alamofire.request( "https://pokeapi.co/api/v2/pokemon\(idPokemon)", method: .get, encoding: JSONEncoding.default).responseJSON  { response in
            switch response.result {
            case .success:
                // do something
                break
            case .failure(let error):
                // handle error
                print("Alert view com net")
                break
            }
        }
    }
}

