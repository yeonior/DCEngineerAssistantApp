//
//  CommutationVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 11.04.2021.
//

import UIKit

class CommutationVC: UITableViewController {
    
    let patches = [
                    Patch(cord: nil, patch: nil, number: nil, designation: "FB00041", length: "12,4 м", sourceCabinet: "R05C01", sourceEquipment: "COD99-ABC01", sourcePort: "3", destinationCabinet: "R06C07", destinationEquipment: "COD99-ABCDEFGHI01", destinationPort: "2"),
                    Patch(cord: nil, patch: nil, number: nil, designation: "TP00387", length: "3,05 м", sourceCabinet: "R08C02", sourceEquipment: "COD99-ABCDEFGHIJK02", sourcePort: "1/MGMT", destinationCabinet: "R08C02", destinationEquipment: "B", destinationPort: "23"),
                    Patch(cord: nil, patch: nil, number: nil, designation: "FB00112", length: "5 м", sourceCabinet: "R04C01", sourceEquipment: "COD99-ABC03", sourcePort: "2/7", destinationCabinet: "R04C01", destinationEquipment: "A", destinationPort: "5"),
                    Patch(cord: nil, patch: nil, number: nil, designation: "TP00018", length: "10 м", sourceCabinet: "R12C15", sourceEquipment: "COD99-ABCD01", sourcePort: "ETH", destinationCabinet: "R12C10", destinationEquipment: "COD99-AB10", destinationPort: "48")
                  ]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CommutationCell
        
        cell.numberLabel.text = "#\(indexPath.row + 1)"
        cell.designationLabel.text = patches[indexPath.row].designation
        cell.lengthLabel.text = patches[indexPath.row].length
        cell.sourceCabinetLabel.text = patches[indexPath.row].sourceCabinet
        cell.sourceEquipmentLabel.text = patches[indexPath.row].sourceEquipment
        cell.sourcePortLabel.text = patches[indexPath.row].sourcePort
        cell.destinationCabinetLabel.text = patches[indexPath.row].destinationCabinet
        cell.destinationEquipmentLabel.text = patches[indexPath.row].destinationEquipment
        cell.destinationPortLabel.text = patches[indexPath.row].destinationPort
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
        
    }

}
