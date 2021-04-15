//
//  StorageManager.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 15.04.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func savePatch(_ patch: Patch) {
        
        try! realm.write {
            realm.add(patch)
        }
    }
    
    static func deletePatch(_ patch: Patch) {
        
        try! realm.write {
            realm.delete(patch)
        }
    }
}
