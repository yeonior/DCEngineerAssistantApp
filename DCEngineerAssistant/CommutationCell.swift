//
//  CommutationCell.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 11.04.2021.
//

import UIKit

class CommutationCell: UITableViewCell {
    
    @IBOutlet weak var cordType: UIImageView!
    @IBOutlet weak var patchType: UIImageView!
    
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var reserveLabel: UILabel!
    
    @IBOutlet weak var sourceCabinetLabel: UILabel!
    @IBOutlet weak var sourceEquipmentLabel: UILabel!
    @IBOutlet weak var sourcePortLabel: UILabel!
    @IBOutlet weak var destinationCabinetLabel: UILabel!
    @IBOutlet weak var destinationEquipmentLabel: UILabel!
    @IBOutlet weak var destinationPortLabel: UILabel!
}
