//
//  HeaderDetailView.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 05/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class HeaderDetailView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell( identifier: String) {
        imageView.image = UIImage(named: identifier)
    }
}
