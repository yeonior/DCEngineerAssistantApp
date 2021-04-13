//
//  CommutationModel.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 11.04.2021.
//

import Foundation

struct Patch {
    
    var cord: String?
    var patch: String?
    
    var number: String?
    var designation: String
    var length: String
    
    var sourceCabinet: String
    var sourceEquipment: String
    var sourcePort: String
    var destinationCabinet: String
    var destinationEquipment: String
    var destinationPort: String
}
