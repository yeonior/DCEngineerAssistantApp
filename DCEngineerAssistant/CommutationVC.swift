//
//  CommutationVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 11.04.2021.
//

import UIKit
import RealmSwift

class CommutationVC: UITableViewController {
    
    var patches: Results<Patch>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        patches = realm.objects(Patch.self)
        
        // Скрываем разделители для отсутствующих ячеек
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patches.isEmpty ? 0 : patches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommutationCell

        let patch = patches[indexPath.row]

        cell.numberLabel.text = "#\(indexPath.row + 1)"
        cell.designationLabel.text = patch.designation
        cell.lengthLabel.text = patch.length
    
        cell.sourceCabinetLabel.text = patch.sourceCabinet
        cell.sourceEquipmentLabel.text = patch.sourceEquipment
        cell.sourcePortLabel.text = patch.sourcePort
        cell.destinationCabinetLabel.text = patch.destinationCabinet
        cell.destinationEquipmentLabel.text = patch.destinationEquipment
        cell.destinationPortLabel.text = patch.destinationPort

        cell.cordType.backgroundColor = #colorLiteral(red: 1, green: 0.9366992116, blue: 0.9999226928, alpha: 1)
        cell.cordType.layer.cornerRadius = 12
        cell.patchType.backgroundColor = #colorLiteral(red: 0.8965173364, green: 1, blue: 0.9313797355, alpha: 1)
        cell.patchType.layer.cornerRadius = 12

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
    // Вызываем алерт контроллер по нажатию на кнопку сортировки
    @IBAction func sortAction(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let nameAZ = UIAlertAction(title: "По имени ↑", style: .default) { _ in }
        let nameZA = UIAlertAction(title: "По имени ↓", style: .default) { _ in }
        let data19 = UIAlertAction(title: "По дате ↑", style: .default) { _ in }
        let data91 = UIAlertAction(title: "По дате ↓", style: .default) { _ in }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(nameAZ)
        actionSheet.addAction(nameZA)
        actionSheet.addAction(data19)
        actionSheet.addAction(data91)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    // Сохраняем новое соединение в новую ячейку
    @IBAction func saveAction(_ segue: UIStoryboardSegue) {
        
        guard let newPatchVC = segue.source as? NewPatchVC else { return }
        newPatchVC.saveNewPatch()
        tableView.reloadData()
    }
}
