//
//  ViewController.swift
//  PMPokedex
//
//  Created by Pedro Meira on 02/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit
import Alamofire

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: "pokemonCell")
        }
    }
    @IBOutlet weak var activityIndicatorCollection: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorView: UIView!
    
    var searchController: UISearchController? {
        didSet {
            searchController?.searchResultsUpdater = self
            searchController?.dimsBackgroundDuringPresentation = false
        }
    }
    var finishFecthDetail: Bool = true
    var pokemons = [Pokemon]()
    var searchPokemons = [Pokemon]()
    
    let sharedNetwork = NetworkManager.sharedNetworkManager
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorCollection.isHidden = true
        activityIndicatorView.isHidden = true
        NetworkManager.sharedNetworkManager.delegateNetwork = self
        pokemons = HelperSupportCSV.parsePokemonCSV()
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.title = "Pokemons"
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsView" {
            if let detailTableView = segue.destination as? DetailTableViewController {
                guard let detailPokemon = sender as? DetailsPokemon else {
                    return
                }
                detailTableView.title = detailPokemon.name
                detailTableView.identifier = detailPokemon.identifier
                detailTableView.detatilPokemon = detailPokemon
            }
        }
    }
    func activityIndicator(status: Bool) {
        self.activityIndicatorCollection.isHidden = status
        activityIndicatorView.isHidden = status
        if !status {
            print("!status: \(!status)")
            self.activityIndicatorCollection.startAnimating()

        } else {
            print("status: \(!status)")
            self.activityIndicatorCollection.stopAnimating()
        }
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if finishFecthDetail == true {
            finishFecthDetail = false
            activityIndicator(status: false)
            guard let searchActive = searchController else { return  }
            let pokemon: Pokemon
            let isActive = searchActive.isActive ? true : false
            if isActive {
                pokemon = searchPokemons[indexPath.row]
            } else {
                pokemon = pokemons[indexPath.row]
            }
            let identifier = pokemon.identifier
            let name = pokemon.name
            sharedNetwork.fetchPokemonDetail(idPokemon: identifier, completed: { result in
                switch result {
                case .success(let details):
                    guard let pHeight = details["height"] as? Int, let pWeight = details["weight"] as? Int, let pOrder = details["order"] as? Int  else { return }
                    let detailsPokemon = DetailsPokemon.init(identifier: identifier, name: name, height: pHeight, weight: pWeight, order: pOrder)
                    self.performSegue(withIdentifier: "showDetailsView", sender: detailsPokemon)
                    self.activityIndicator(status: true)
                    self.finishFecthDetail = true

                case .failure(let error):
                    print(error)
                    self.activityIndicator(status: true)
                }
            })
        }
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let searchActive = searchController else { return 0 }
        let isActive = searchActive.isActive ? true : false
        if isActive {
            return searchPokemons.count
        } else {
            return pokemons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell, let searchActive = searchController else {
            return UICollectionViewCell()
        }
        let isActive = searchActive.isActive ? true : false
        if isActive {
            let searchPokemon = searchPokemons[indexPath.row]
            cell.configureCell(identifier: searchPokemon.identifier, name: searchPokemon.name)
        } else {
            let pokemon = pokemons[indexPath.row]
            cell.configureCell(identifier: pokemon.identifier, name: pokemon.name)
        }
        return cell
    }
}

extension CollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let stringSearch = searchController.searchBar.text?.lowercased() else { return }
        searchPokemons = pokemons.filter({$0.name.lowercased().range(of: stringSearch) != nil})
        if stringSearch.trimmingCharacters(in: .whitespaces) == "" {
            searchPokemons = pokemons
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return false
    }
}

// MARK: - Network Reachability Delegate
extension CollectionViewController: NetworkReachabilityDelegate {
    func isReachability(status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        switch status {
        case .notReachable, .unknown:
            guard let loadViewController = self.storyboard?.instantiateViewController(withIdentifier: "loadScreen") as? LoadingViewController else {
                return
            }
            self.navigationController?.pushViewController(loadViewController, animated: true)
        default:
            break
        }
    }
}
