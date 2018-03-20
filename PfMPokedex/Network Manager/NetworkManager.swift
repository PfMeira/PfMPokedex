//
//  NetworkManager.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 03/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import Alamofire

protocol NetworkReachabilityDelegate: class {
    func isReachability(status: NetworkReachabilityManager.NetworkReachabilityStatus)
}

class NetworkManager {
    static let sharedNetworkManager = NetworkManager()
    weak var delegateNetwork: NetworkReachabilityDelegate?
    let reachabilityManager = Alamofire.NetworkReachabilityManager()

    private init() {
        isReachability()
    }
    
    func isReachability() {
        reachabilityManager?.listener = { status in
            self.delegateNetwork?.isReachability(status: status)
        }
        reachabilityManager?.startListening()
    }
    let getPokemons = "https://pokeapi.co/api/v2/pokemon/"
    typealias FetchDetail = (Result<[String: AnyObject]>) -> Void
    
    func fetchPokemonDetail(idPokemon: String, completed: @escaping FetchDetail) {
        Alamofire.request( "\(getPokemons)\(idPokemon)", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            let result = response.result
            switch result {
            case .success(let details):
                guard let detail = details as? [String: AnyObject] else {
                    let error = NSError()
                    completed(.failure(error))
                    return
                }
                completed(.success(detail))
            case .failure(let error):
                print("Alert view com net")
                completed(.failure(error))
            }
        }
    }
}
