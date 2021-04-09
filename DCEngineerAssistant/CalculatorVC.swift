//
//  CalculatorVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 08.04.2021.
//

import UIKit

class CalculatorVC: UIViewController {
    
    var firstOktetOfAddress, secondOktetOfAddress, thirdOktetOfAddress, fourthOktetOfAddress: UInt8?
    var firstOktetOfMask, secondOktetOfMask, thirdOktetOfMask, fourthOktetOfMask: UInt8?
    var masksDictionary = [
        16: "255.255.0.0",
        17: "255.255.128.0",
        18: "255.255.192.0",
        19: "255.255.224.0",
        20: "255.255.240.0",
        21: "255.255.248.0",
        22: "255.255.252.0",
        23: "255.255.254.0",
        24: "255.255.255.0",
        25: "255.255.255.128",
        26: "255.255.255.192",
        27: "255.255.255.224",
        28: "255.255.255.240",
        29: "255.255.255.248",
        30: "255.255.255.252"
    ]
    
    @IBOutlet weak var net: UITextField!
    @IBOutlet weak var broadcast: UITextField!
    @IBOutlet weak var fullMask: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mask: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        address.delegate = self
        mask.delegate = self

    }
    
    // Скрываем клавиатуры для любых объектов
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

extension  CalculatorVC: UITextFieldDelegate {
    
    func verifyOctet(test: String) -> Bool {
        let pattern = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])[.]){0,3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])?$"
        let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
        let result = regexText.evaluate(with: test)
        return result
    }

    func verifyIP(test: String) -> Bool {
        let pattern = "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)"
        let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
        let result = regexText.evaluate(with: test)
        return result
    }
    
    func verifyMask(test: String) -> Bool {
        let pattern = "([0-9]|1[0-9]|2[0-9]|3[0-2]|25[0-5])"
        let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
        let result = regexText.evaluate(with: test)
        return result
    }
    
    func calculationNet() {
        guard let a = firstOktetOfAddress, let b = firstOktetOfMask, let c = secondOktetOfAddress, let d = secondOktetOfMask, let e = thirdOktetOfAddress, let f = thirdOktetOfMask, let g = fourthOktetOfAddress, let h = fourthOktetOfMask else { return }
        net.text = "\(a & b).\(c & d).\(e & f).\(g & h)"
    }
    
    // Проводим расчет перед началом редактирования
    func textFieldDidBeginEditing(_ textField: UITextField) {
        SetCorrectDecimalKeyboard(UITextField: textField)
    }
    
    // Проводим расчет во время редактирования
    func textFieldDidChangeSelection(_ textField: UITextField) {

    }
    
    // Проводим расчет после редактирования
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        
        case address:
            let buffer = address.text!
            let array = buffer.components(separatedBy: ".")
            if array.count == 4 {
                firstOktetOfAddress = UInt8(array[0])
                secondOktetOfAddress = UInt8(array[1])
                thirdOktetOfAddress = UInt8(array[2])
                fourthOktetOfAddress = UInt8(array[3])
                
                calculationNet()
            }
            
        case mask:
            
            let buffer = mask.text!
            let x = Int(buffer)
            if x != nil {
                let mask = masksDictionary[x!]
                fullMask.text = String(mask!)
                let array = mask!.components(separatedBy: ".")
                firstOktetOfMask = UInt8(array[0])
                secondOktetOfMask = UInt8(array[1])
                thirdOktetOfMask = UInt8(array[2])
                fourthOktetOfMask =  UInt8(array[3])
                
                calculationNet()
            }
            
        default:
            return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField {
        case address:
            let addressText = address.text ?? ""
            let addressState = verifyOctet(test: addressText + string) || verifyIP(test: addressText + string)
            return addressState
        case mask:
            let maskText = mask.text ?? ""
            let maskState = verifyMask(test: maskText + string)
            return maskState
        default:
            return false
        }
    }
    
    func SetCorrectDecimalKeyboard(UITextField: UITextField)  {
       
        let language = Locale.current.identifier
       
        if (language == "en_GB" || language == "en_US") {
           
            print("[LOG] \(language) - Setting Decimal keyboard")
            UITextField.keyboardType = UIKeyboardType.decimalPad
        }
        else {
           
            print("[LOG] \(language) - Setting Numbers & Punctuation keyboard")
            UITextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        }
    }
    
//    //When Enter is tapped
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    

}
