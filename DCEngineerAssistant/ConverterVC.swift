//
//  ViewController.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 08.04.2021.
//

import UIKit

class ConverterVC: UIViewController {
    
    var convertMode: Bool?

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        convertMode = false
        firstLabel.text = "1 ft"
        secondLabel.text = "0.3 m"
    }

}

extension ConverterVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Количество компонентов
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // Количество значений для каждого компонента
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 2
        } else {
            return 100
        }
    }
    
    // Назначение имен для значений
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            if row == 0 {
                return "ft"
            } else {
                return "m"
            }
        } else {
            return "\(row + 1)"
        }
    }

    
    // Настройка действий при выборе значения
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Переключение режима конвертации
        if component == 0 && row == 0 {
            convertMode = false
        } else if component == 0 && row == 1 {
            convertMode = true
        }
        
        // Конвертация
        convert()
    }
    
    // Метод конвертации
    func convert() {
        
        if convertMode == false {
            let value = pickerView.selectedRow(inComponent: 1) + 1
            let convertResult = round(Double(value) * 30.48)/100
            firstLabel.text = "\(value) ft"
            secondLabel.text = "\(convertResult) m"
        } else {
            let value = pickerView.selectedRow(inComponent: 1) + 1
            let convertResult = round(Double(value) * 328.084)/100
            firstLabel.text = "\(value) m"
            secondLabel.text = "\(convertResult) ft"
        }
        
    }
    
}
