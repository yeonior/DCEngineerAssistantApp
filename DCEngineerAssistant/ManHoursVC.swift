//
//  ManHoursVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 08.04.2021.
//

import UIKit

class ManHoursVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var equipment: UITextField!
    @IBOutlet weak var connections: UITextField!
    
    @IBOutlet weak var unloading: UISwitch!
    @IBOutlet weak var mounting: UISwitch!
    @IBOutlet weak var commutation: UISwitch!
    @IBOutlet weak var configuration: UISwitch!
    @IBOutlet weak var dcops: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
