//
//  DetailTableViewController.swift
//  PfMPokedex
//
//  Created by Pedro Meira on 04/03/2018.
//  Copyright © 2018 Pedro Meira. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var headerDetailView: HeaderDetailView!
    
    var identifier: String!
    var detatilPokemon: DetailsPokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let idRapped = identifier else {
            return
        }
        headerDetailView.configureCell(identifier: idRapped)
    }
}

extension DetailTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let height = detatilPokemon?.height, let cell = tableView.dequeueReusableCell(withIdentifier: "heightCell", for: indexPath) as? HeightDetailCell else {
                return UITableViewCell()
            }
            cell.configureCell(height: height)
            return cell
            
        case 1:
            guard let weight = detatilPokemon?.weight, let cell = tableView.dequeueReusableCell(withIdentifier: "weightCell", for: indexPath)  as? WeightDetailCell else {
                return UITableViewCell()
            }
            cell.configureCell(weight: weight)
            return cell
            
        case 2:
            guard let order = detatilPokemon?.order, let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderDetailCell else {
                return UITableViewCell()
            }
            cell.configureCell(order: order)
            return cell
            
        default:
            print("Erros")
        }
        return UITableViewCell()
    }
}
