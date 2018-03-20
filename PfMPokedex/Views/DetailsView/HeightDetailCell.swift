//
//  HeightDetailCell.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 06/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class HeightDetailCell: UITableViewCell {
 
    @IBOutlet var  heightLabel: UILabel!
    
    func configureCell(height: Int) {
            heightLabel.text = String(height)
    }
}
