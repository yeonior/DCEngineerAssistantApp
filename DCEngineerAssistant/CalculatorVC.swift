//
//  CalculatorVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 08.04.2021.
//

import UIKit

class CalculatorVC: UIViewController {
    
    
    var firstOktetOfNet, secondOktetOfNet, thirdOktetOfNet, fourthOktetOfNet: UInt8?
    var firstOktetOfMask, secondOktetOfMask, thirdOktetOfMask, fourthOktetOfMask: UInt8?
    var firstOktetOfAddress, secondOktetOfAddress, thirdOktetOfAddress, fourthOktetOfAddress: UInt8?
    
    var masksDictionary = [
        0: "0.0.0.0",
        1: "128.0.0.0",
        2: "192.0.0.0",
        3: "224.0.0.0",
        4: "240.0.0.0",
        5: "248.0.0.0",
        6: "252.0.0.0",
        7: "254.0.0.0",
        8: "255.0.0.0",
        9: "255.128.0.0",
        10: "255.192.0.0",
        11: "255.224.0.0",
        12: "255.240.0.0",
        13: "255.248.0.0",
        14: "255.252.0.0",
        15: "255.254.0.0",
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
        30: "255.255.255.252",
        31: "255.255.255.254",
        32: "255.255.255.255"
    ]
    
    @IBOutlet weak var net: UITextField!
    @IBOutlet weak var broadcast: UITextField!
    @IBOutlet weak var mask: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var prefix: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        address.delegate = self
        prefix.delegate = self
        
        net.text = "N/A"
        broadcast.text = "N/A"
        mask.text = "N/A"
    }
    
    // Скрываем клавиатуру при тапе для любых объектов
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension  CalculatorVC: UITextFieldDelegate {
    
    // Проверка октетов адреса
    func verifyOctet(test: String) -> Bool {
        let pattern = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])[.]){0,3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])?$"
        let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
        let result = regexText.evaluate(with: test)
        return result
    }
    
    // Проверка адреса целиком
    func verifyIP(test: String) -> Bool {
        let pattern = "(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)\\.(25[0-5]|2[0-4]\\d|1\\d{2}|\\d)"
        let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
        let result = regexText.evaluate(with: test)
        return result
    }
    
    // Проверка маски
    func verifyMask(test: String) -> Bool {
        let pattern = "([0-9]|1[0-9]|2[0-9]|3[0-2]|25[0-5])"
        let regexText = NSPredicate(format: "SELF MATCHES %@", pattern)
        let result = regexText.evaluate(with: test)
        return result
    }
    
    // Расчет адреса сети
    func calculationNet() {
        guard let a = firstOktetOfAddress,
              let b = firstOktetOfMask,
              let c = secondOktetOfAddress,
              let d = secondOktetOfMask,
              let e = thirdOktetOfAddress,
              let f = thirdOktetOfMask,
              let g = fourthOktetOfAddress,
              let h = fourthOktetOfMask else { return }
        
        firstOktetOfNet = a & b
        secondOktetOfNet = c & d
        thirdOktetOfNet = e & f
        fourthOktetOfNet = g & h
        
        net.text = "\(a & b).\(c & d).\(e & f).\(g & h)"
    }
    
    // Расчет широковещательного адреса
    func calculationBroadcast() {
        guard let a = firstOktetOfNet,
              let b = firstOktetOfMask,
              let c = secondOktetOfNet,
              let d = secondOktetOfMask,
              let e = thirdOktetOfNet,
              let f = thirdOktetOfMask,
              let g = fourthOktetOfNet,
              let h = fourthOktetOfMask else { return }
        
        broadcast.text = "\(a | ~b).\(c | ~d).\(e | ~f).\(g | ~h)"
    }
    
    // Общий расчет
    func textFieldCheckAndCalculation(_ textField: UITextField) {
        
        switch textField {
        
        case address:
            
            let buffer = address.text!
            let array = buffer.components(separatedBy: ".")
            
            if array.count == 4 && array[3] != "" {
                firstOktetOfAddress = UInt8(array[0])
                secondOktetOfAddress = UInt8(array[1])
                thirdOktetOfAddress = UInt8(array[2])
                fourthOktetOfAddress = UInt8(array[3])
                
                calculationNet()
                calculationBroadcast()
            } else {
                net.text = "N/A"
                broadcast.text = "N/A"
                firstOktetOfNet = nil; secondOktetOfNet = nil; thirdOktetOfNet = nil; fourthOktetOfNet = nil
                firstOktetOfAddress = nil; secondOktetOfAddress = nil; thirdOktetOfAddress = nil; fourthOktetOfAddress = nil
            }
            
        case prefix:
            
            let buffer = prefix.text!
            let x = Int(buffer)
            
            if x != nil {
                let currentMask = masksDictionary[x!]
                mask.text = String(currentMask!)
                let array = currentMask!.components(separatedBy: ".")
                firstOktetOfMask = UInt8(array[0])
                secondOktetOfMask = UInt8(array[1])
                thirdOktetOfMask = UInt8(array[2])
                fourthOktetOfMask =  UInt8(array[3])
                
                calculationNet()
                calculationBroadcast()
            } else {
                net.text = "N/A"
                broadcast.text = "N/A"
                mask.text = "N/A"
                firstOktetOfMask = nil; secondOktetOfMask = nil; thirdOktetOfMask = nil; fourthOktetOfMask = nil
            }
            
        default: return
        }
    }
    
    // Перед редактированием
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == address {
            SetCorrectDecimalKeyboard(UITextField: textField)
        }
    }
    
    // Во время редактирования
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldCheckAndCalculation(textField)
    }
    
    // После редактирования
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldCheckAndCalculation(textField)
    }
    
    // Проверка вводимой информации
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case address:
            let addressText = address.text ?? ""
            let addressState = verifyOctet(test: addressText + string) || verifyIP(test: addressText + string)
            return addressState
        case prefix:
            let maskText = prefix.text ?? ""
            let maskState = verifyMask(test: maskText + string)
            return maskState
        default:
            return false
        }
    }
    
    // Показ клавиатуры в зависимости от языка
    func SetCorrectDecimalKeyboard(UITextField: UITextField)  {
        
        let language = Locale.current.identifier
        
        if (language == "en_GB" || language == "en_US") {
            UITextField.keyboardType = UIKeyboardType.decimalPad
        } else {
            UITextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        }
    }
    
    // Скрываем клавиатуру по нажатию на Ввод
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
