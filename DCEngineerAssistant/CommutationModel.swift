//
//  CommutationModel.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 11.04.2021.
//

import RealmSwift

class Patch: Object {
    
    @objc dynamic var cord: String?
    @objc dynamic var patch: String?
    
    @objc dynamic var number: String?
    @objc dynamic var designation: String?
    @objc dynamic var length: String?
    
    @objc dynamic var sourceCabinet: String?
    @objc dynamic var sourceEquipment: String?
    @objc dynamic var sourcePort: String?
    @objc dynamic var destinationCabinet: String?
    @objc dynamic var destinationEquipment: String?
    @objc dynamic var destinationPort: String?
    
    // Инициализатор для класса
    convenience init(cord: String?,
                     patch: String?,
                     
                     number: String?,
                     designation: String?,
                     length: String?,
                     
                     sourceCabinet: String?,
                     sourceEquipment: String?,
                     sourcePort: String?,
                     destinationCabinet: String?,
                     destinationEquipment: String?,
                     destinationPort: String?)          {
        
        // сперва происходит инициализация дефолтными значениями
        self.init()
        
        self.cord = cord
        self.patch = patch
        
        self.number = number
        self.designation =  designation
        self.length = length
        
        self.sourceCabinet = sourceCabinet
        self.sourceEquipment = sourceEquipment
        self.sourcePort = sourcePort
        self.destinationCabinet = destinationCabinet
        self.destinationEquipment = destinationEquipment
        self.destinationPort = destinationPort
    }
}
