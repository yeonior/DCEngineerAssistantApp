//
//  CommutationCell.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 11.04.2021.
//

import UIKit

class CommutationCell: UITableViewCell {
    
    @IBOutlet weak var cordTypeStatus: UIImageView!
    @IBOutlet weak var patchTypeStatus: UIImageView!
    
    @IBOutlet weak var cordLabelLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var reserveLabel: UILabel!
    
    @IBOutlet weak var sourceCabinetLabel: UILabel!
    @IBOutlet weak var sourceEquipmentLabel: UILabel!
    @IBOutlet weak var sourcePortLabel: UILabel!
    @IBOutlet weak var destinationCabinetLabel: UILabel!
    @IBOutlet weak var destinationEquipmentLabel: UILabel!
    @IBOutlet weak var destinationPortLabel: UILabel!
}
