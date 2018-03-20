//
//  WeightDetailCell.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 08/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class WeightDetailCell: UITableViewCell {
    
    @IBOutlet var  weightLabel: UILabel!

    func configureCell(weight: Int) {
        weightLabel.text = String(weight)
    }
}
