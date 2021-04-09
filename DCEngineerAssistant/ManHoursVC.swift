//
//  ManHoursVC.swift
//  DCEngineerAssistant
//
//  Created by ruslan on 08.04.2021.
//

import UIKit

class ManHoursVC: UIViewController {
    
    var equipmentNumber: Double?
    var connectionsNumber: Double?
    
    var unloadingResult: Double?
    var mountingResult: Double?
    var commutationResult: Double?
    var configurationResult: Double?
    var dcopsResult: Double?
    
    @IBOutlet weak var unloading: UISwitch!
    @IBOutlet weak var mounting: UISwitch!
    @IBOutlet weak var commutation: UISwitch!
    @IBOutlet weak var configuration: UISwitch!
    @IBOutlet weak var dcops: UISwitch!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var equipment: UITextField!
    @IBOutlet weak var connections: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "0 ч 0 м"
        
        // Делегируем тексфилды для активации метода ограничения символов
        equipment.delegate = self
        connections.delegate = self
        
        createToolbar()        
    }
    
    // Скрываем клавиатуры для любых объектов
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Расчет трудозатрат
    private func calculation() {
        
        // Преобразуем введную информацию типа String? в тип Double?
        equipmentNumber = Double(equipment.text!)
        connectionsNumber = Double(connections.text!)
        
        // При наличии данных в двух полях
        if let a = equipmentNumber, let b = connectionsNumber {
            
            unloadingResult = a * 20
            mountingResult = a * 30
            commutationResult = b * 20
            configurationResult = a * 20 * 2 / 3
            dcopsResult = a * 3 * 1.2 + b * 3 * 1.5
            
            sum()
        } else
        
        // При наличии данных в первом поле
        if let a = equipmentNumber, connectionsNumber == nil {
            unloadingResult = a * 20
            mountingResult = a * 30
            configurationResult = a * 20 * 2 / 3
            dcopsResult = a * 3 * 1.2
            
            sum()
        } else
        
        // При наличии данных во втором поле
        if let b = connectionsNumber, equipmentNumber == nil {
            commutationResult = b * 20
            dcopsResult = b * 3 * 1.5
            
            sum()
        } else
        
        // При отсутствии данных в полях
        {
            label.text = "0 ч 0 м"
        }
        
        // Обнуляем свойства для того, чтобы они не суммировались при следующих расчетах
        unloadingResult = nil
        mountingResult = nil
        commutationResult = nil
        configurationResult = nil
        dcopsResult = nil
        
    }
    
    // Сумма времени раличных видов работ, в зависимости от их наличия
    private func sum() {
        
        var sum: Double = 0
        
        if unloading.isOn && unloadingResult != nil {
            sum += unloadingResult!
        }
        if mounting.isOn && mountingResult != nil {
            sum += mountingResult!
        }
        if commutation.isOn && commutationResult != nil {
            sum += commutationResult!
        }
        if configuration.isOn && configurationResult != nil {
            sum += configurationResult!
        }
        if dcops.isOn && dcopsResult != nil {
            sum += dcopsResult!
        }
        
        // Преобразуем итоговое значение к типу часы/минуты
        sum = round(sum * 1.3 / 60 * 10) / 10
        let sumHours = Int(sum)
        let sumMinutes = Int(round(60 * (sum - Double(sumHours))))
        
        label.text = "\(sumHours) ч \(sumMinutes) м"
    }
    
    // Добавляем тулбар с кнопкой Done для клавиатуры
    private func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction))
        toolBar.items = [doneButton]
        toolBar.isUserInteractionEnabled = true
        equipment.inputAccessoryView = toolBar
        connections.inputAccessoryView = toolBar
        
    }
    
    // Действие по нажатию на кнопку Done клавиатуры
    @objc private func doneAction() {
        calculation()
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func unloading(_ sender: UISwitch) {
        calculation()
    }
    
    @IBAction func mounting(_ sender: UISwitch) {
        calculation()
    }
    
    @IBAction func commutation(_ sender: UISwitch) {
        calculation()
    }
    
    @IBAction func configuration(_ sender: UISwitch) {
        calculation()
    }
    
    @IBAction func dcops(_ sender: UISwitch) {
        calculation()
    }
    
}

extension ManHoursVC: UITextFieldDelegate {
    
    // Проводим расчет перед началом редактирования
    func textFieldDidBeginEditing(_ textField: UITextField) {
        calculation()
    }
    
    // Проводим расчет во время редактирования
    func textFieldDidChangeSelection(_ textField: UITextField) {
        calculation()
    }
    
    // Проводим расчет после редактирования
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculation()
    }
    
    // Ограничиваем количество символов в текстфилде
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // получаем текущий текст
        let currentText = textField.text ?? ""

        // измеряем диапазон текущего текста
        guard let stringRange = Range(range, in: currentText) else { return false }

        // замнеяем текущий текст на новый
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // убеждаемся, что символов в новом тексте <= 4
        return updatedText.count <= 4
    }
        
}
