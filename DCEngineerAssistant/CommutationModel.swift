//
//  CommutationModel.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 11.04.2021.
//

import Foundation

struct Patch {
    
    var cordType: String?
    var patchType: String?
    
    var cordLabel: String
    var length: String
    var reserve: String?
    
    var sourceCabinet: String
    var sourceEquipment: String
    var sourcePort: String
    var destinationCabinet: String
    var destinationEquipment: String
    var destinationPort: String
}
