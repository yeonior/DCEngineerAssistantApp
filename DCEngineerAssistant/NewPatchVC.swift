//
//  NewPatchVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 13.04.2021.
//

import UIKit

class NewPatchVC: UITableViewController {
    
    var newPatch: Patch?
    
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var lengthTF: UITextField!
    
    @IBOutlet weak var designationTF: UITextField!
    @IBOutlet weak var patchTF: UITextField!
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var specialistTF: UITextField!
    
    @IBOutlet weak var sourceCabinetTF: UITextField!
    @IBOutlet weak var sourceEquipmentTF: UITextField!
    @IBOutlet weak var sourcePortTF: UITextField!
    
    @IBOutlet weak var destinationCabinetTF: UITextField!
    @IBOutlet weak var destinationEquipmentTF: UITextField!
    @IBOutlet weak var destinationPortTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeTF.delegate = self
        categoryTF.delegate = self
        lengthTF.delegate = self

        designationTF.delegate = self
        patchTF.delegate = self
        dataTF.delegate = self
        specialistTF.delegate = self

        sourceCabinetTF.delegate = self
        sourceEquipmentTF.delegate = self
        sourcePortTF.delegate = self

        destinationCabinetTF.delegate = self
        destinationEquipmentTF.delegate = self
        destinationPortTF.delegate = self
        
        // Скрываем клавиатуру по тапу
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 3
        case 3:
            return 3
        default:
            return 0
        }
    }
    
    // Сохранение нового соединения
    func saveNewPatch() {
        
        newPatch = Patch(cord: nil,
                             patch: nil,
                             number: nil,
                             designation: designationTF.text!,
                             length: lengthTF.text!,
                             sourceCabinet: sourceCabinetTF.text!,
                             sourceEquipment: sourceEquipmentTF.text!,
                             sourcePort: sourcePortTF.text!,
                             destinationCabinet: destinationCabinetTF.text!,
                             destinationEquipment: destinationEquipmentTF.text!,
                             destinationPort: destinationPortTF.text!)
        
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension NewPatchVC: UITextFieldDelegate {

    // Скрываем клавиатуру по нажатию на кнопку Готово
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
