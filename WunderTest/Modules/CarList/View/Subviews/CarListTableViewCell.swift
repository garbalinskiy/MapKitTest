//
//  CarListTableViewCell.swift
//  WunderTest
//
//  Created by Sergey Garbalinskiy on 9/20/18.
//  Copyright © 2018 Sergey Garbalinskiy. All rights reserved.
//

import UIKit

class CarListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var engineTypeLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var exteriorLabel: UILabel!
    @IBOutlet weak var interiorLabel: UILabel!

    func configureWith(_ viewModel: CarListViewModel) {
        nameLabel.text = viewModel.name
        vinLabel.text = viewModel.vin
        addressLabel.text = viewModel.address
        coordinatesLabel.text = viewModel.coordinates
        engineTypeLabel.text = viewModel.engineType
        fuelLabel.text = viewModel.fuel
        exteriorLabel.text = viewModel.exterior
        interiorLabel.text = viewModel.interior
    }
 
}
