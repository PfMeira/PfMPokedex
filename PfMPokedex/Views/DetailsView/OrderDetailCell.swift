//
//  OrderDetailCell.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 08/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {
    
    @IBOutlet weak var orderLabel: UILabel!
    
    func configureCell(order: Int) {
        orderLabel.text = String(order)
    }
}
