//
//  ViewController.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 08.04.2021.
//

import UIKit

class ConverterVC: UIViewController {
    
    var method: ConvertMethod = .ft
    var firstValue: Int = 1 {
        didSet {
            firstLabel.text = firstValue.description + " " + (method == .ft ? "ft" : "m")
        }
    }
    
    var secondValue: Double = 0.3 {
        didSet {
            secondLabel.text = secondValue.description + " " + (method == .ft ? "m" : "ft")
        }
    }

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        convert()
    }
    
    // convertation
    func convert() {
                
        var coef = 0.3048
        
        switch method {
        case .ft:
            coef = 0.3048
        case .m:
            coef = 3.28084
        }
        
        let value = pickerView.selectedRow(inComponent: 1) + 1
        let convertedResult = round(Double(value) * coef * 100) / 100
        
        firstValue = value
        secondValue = convertedResult
    }
}

extension ConverterVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 2
        } else {
            return 100
        }
    }
    
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

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 && row == 0 {
            method = .ft
        } else if component == 0 && row == 1 {
            method = .m
        }
        
        convert()
    }
}

enum ConvertMethod {
    case ft
    case m
}
