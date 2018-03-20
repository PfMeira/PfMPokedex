//
//  PokemonCell.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 03/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    
    func configureCell(identifier: String, name: String) {
        namePokemon?.text = name
        let image = UIImage(named: "\(identifier)")
        self.imagePokemon.image = image
    }
}
