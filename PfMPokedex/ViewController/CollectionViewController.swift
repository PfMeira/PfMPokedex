//
//  ViewController.swift
//  PMPokedex
//
//  Created by Pedro Meira on 02/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Pokedex"
        collectionView.register(UINib(nibName: "DetailPokedexCell", bundle: nil), forCellWithReuseIdentifier: "DetailCell")
        
        parsePokemonCSV()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let cvs = try CSV(contentsOfURL: path)
            let rows = cvs.rows
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                print(pokeId, name)
                //let poke =  Pokemon(name: name, pokedexId: pokeId)
                //pokemonArray.append(poke)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailPokedexCell
        
        //cell?.configureCell()
        //cell?.backgroundColor = UIColor.lightGray
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}

