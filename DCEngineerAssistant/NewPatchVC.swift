//
//  NewPatchVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 13.04.2021.
//

import UIKit

class NewPatchVC: UITableViewController {
    
    var currentPatch: Patch?
    
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
        
        setupEditScreen()
        
        tableView.tableFooterView = UIView()
        
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
    func savePatch() {
        
        let newPatch = Patch(cord: typeTF.text,
                             patch: patchTF.text,
                             
                             number: nil,
                             designation: designationTF.text,
                             length: lengthTF.text,
                             
                             sourceCabinet: sourceCabinetTF.text,
                             sourceEquipment: sourceEquipmentTF.text,
                             sourcePort: sourcePortTF.text,
                             destinationCabinet: destinationCabinetTF.text,
                             destinationEquipment: destinationEquipmentTF.text,
                             destinationPort: destinationPortTF.text)
        
        if currentPatch != nil {
            
            try! realm.write {
                currentPatch!.cord = typeTF.text
                currentPatch!.patch = patchTF.text
                
                currentPatch!.designation =  designationTF.text
                currentPatch!.length = lengthTF.text
                
                currentPatch!.sourceCabinet = sourceCabinetTF.text
                currentPatch!.sourceEquipment = sourceEquipmentTF.text
                currentPatch!.sourcePort = sourcePortTF.text
                currentPatch!.destinationCabinet = destinationCabinetTF.text
                currentPatch!.destinationEquipment = destinationEquipmentTF.text
                currentPatch!.destinationPort = destinationPortTF.text
            }
        } else {
            StorageManager.savePatch(newPatch)
        }
    }
    
    // Метод адресации значений выбранной ячейки текстфилдам
    private func setupEditScreen() {
        if currentPatch != nil {
            
            // Вызов метода изменения навигейшн бара
            setupNavigationBar()
            
            typeTF.text = currentPatch?.cord
            patchTF.text = currentPatch?.patch
            
            designationTF.text = currentPatch?.designation
            lengthTF.text = currentPatch?.length
            
            sourceCabinetTF.text = currentPatch?.sourceCabinet
            sourceEquipmentTF.text = currentPatch?.sourceEquipment
            sourcePortTF.text = currentPatch?.sourcePort
            destinationCabinetTF.text = currentPatch?.destinationCabinet
            destinationEquipmentTF.text = currentPatch?.destinationEquipment
            destinationPortTF.text = currentPatch?.destinationPort
        }
    }
    
    // Метод изменения навигейшн бара
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .systemOrange
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPatch?.designation
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
