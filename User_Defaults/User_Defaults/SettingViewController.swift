//
//  SettingViewController.swift
//  User_Defaults
//
//  Created by Amy Alsaydi on 1/13/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

// delegating object

protocol SettingDelegate {
    func didChangeSign(sign: String)
    func didChangeName(name: String)
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var pickerData: [String] = [String]()
    
    var settingsDelegate: SettingDelegate?
    
    var sign = "gemini" {
        didSet {
            UserPreference.shared.updateSign(sign: sign)
            settingsDelegate?.didChangeSign(sign: sign)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        textFeild.delegate = self
        
        datePicker.datePickerMode = .date
        
        pickerData = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
    }
    
    func getSign(date: String){
        
        // date in this string format "dd.MM"
        
        let dateParts = date.components(separatedBy: ".")
        
        let day = Int(dateParts[0]) ?? 1
        let month = Int(dateParts[1]) ?? 1
        
        if month == 3 && (21...31).contains(day) || month == 4 && (1...19).contains(day) {
            sign = "aries"
        }
        if month == 4 && (20...30).contains(day) || month == 5 && (1...20).contains(day) {
            sign = "taurus"
        }
        
        if month == 5 && (21...31).contains(day) || month == 6 && (1...20).contains(day) {
            sign = "gemini"
        }
        
        if month == 6 && (21...30).contains(day) || month == 7 && (1...22).contains(day) {
            sign = "cancer"
        }
        
        if month == 7 && (23...31).contains(day) || month == 8 && (1...22).contains(day) {
            sign = "leo"
        }
        if month == 8 && (23...31).contains(day) || month == 9 && (1...22).contains(day) {
            sign = "virgo"
        }
        
        if month == 9 && (23...31).contains(day) || month == 10 && (1...22).contains(day) {
            sign = "libra"
        }
        
        if month == 10 && (23...31).contains(day) || month == 11 && (1...21).contains(day) {
            sign = "scorpio"
        }
        
        if month == 11 && (22...31).contains(day) || month == 12 && (1...21).contains(day) {
            sign = "sagittarius"
        }
        
        if month == 12 && (22...31).contains(day) || month == 1 && (1...19).contains(day) {
            sign = "capricorn"
        }
        if month == 1 && (20...31).contains(day) || month == 2 && (1...18).contains(day) {
            sign = "aquarius"
        }
        
        if month == 2 && (19...31).contains(day) || month == 3 && (1...20).contains(day) {
            sign = "pisces"
        }
        
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
      
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        let date = dateFormatter.string(from: sender.date)
        //print(date)
        
        getSign(date: date)
        
        
    }
    

}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        sign = pickerData[row].lowercased() as String
        
    }
    
}

extension SettingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let name = textFeild.text ?? ""
        UserPreference.shared.updateName(name: name)
        settingsDelegate?.didChangeName(name: name)
    }
    
}
