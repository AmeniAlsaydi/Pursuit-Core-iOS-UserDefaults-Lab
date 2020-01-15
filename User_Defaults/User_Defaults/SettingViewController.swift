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
    @IBOutlet weak var signPickerView: UIPickerView!
    @IBOutlet weak var customDatePicker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var settingsDelegate: SettingDelegate?
    
    var months: Array<String> = Calendar.current.monthSymbols
    var daysArray = Array(1...31)
    var date = ""
    var day = "1"
    var month = "January"
    
    var sign = "gemini" {
        didSet {
            UserPreference.shared.updateSign(sign: sign)
            settingsDelegate?.didChangeSign(sign: sign)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signPickerView.dataSource = self
        signPickerView.delegate = self
        customDatePicker.delegate = self
        customDatePicker.dataSource = self
        
        textFeild.delegate = self
        
        // datePicker.datePickerMode = .date
        
        pickerData = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
    }
    
    func getDate(date: Date) {
        switch date {
        case HoroscopeDates.AquariusStart.date()...HoroscopeDates.AquariusEnd.date():
            sign = "aquarius"
        case HoroscopeDates.AriesStart.date()...HoroscopeDates.AriesEnd.date():
            sign = "aries"
        case HoroscopeDates.CancerStart.date()...HoroscopeDates.CancerEnd.date():
            sign = "cancer"
            // bug is here 
        case HoroscopeDates.CapricornStart.date()...HoroscopeDates.CapriocornEndYear.date():
            sign = "capricorn"
        case HoroscopeDates.CapricornStartYear.date()...HoroscopeDates.CapricornEnd.date():
            sign = "capricorn"
        case HoroscopeDates.GeminiStart.date()...HoroscopeDates.GeminiEnd.date():
            sign = "gemini"
        case HoroscopeDates.LeoStart.date()...HoroscopeDates.LeoEnd.date():
            sign = "leo"
        case HoroscopeDates.VirgoStart.date()...HoroscopeDates.VirgoEnd.date():
            sign = "virgo"
        case HoroscopeDates.LibraStart.date()...HoroscopeDates.LibraEnd.date():
            sign = "libra"
        case HoroscopeDates.ScorpioStart.date()...HoroscopeDates.ScorpioEnd.date():
            sign = "scorpio"
        case HoroscopeDates.SagittariusStart.date()...HoroscopeDates.SagittariusEnd.date():
            sign = "sagittarius"
        case HoroscopeDates.TaurusStart.date()...HoroscopeDates.TaurusEnd.date():
            sign = "taurus"
        case HoroscopeDates.PiscesStart.date()...HoroscopeDates.PiscesEnd.date():
            sign = "pisces"
            
        default:
            print("out of range")
            
        }
    }
    
    
}

extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if signPickerView == pickerView {
            return 1
        } else if pickerView == customDatePicker {
            return 2
        }
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == signPickerView {
            return pickerData.count
        }
        if pickerView == customDatePicker {
            if component == 0 {
                return daysArray.count
            }
            if component == 1 {
                return 12
                
            }
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == signPickerView {
            return pickerData[row]
        }
            
        else if pickerView == customDatePicker {
            if component == 0{
                return  daysArray[row].description
            } else {
                return months[row]
            }
        }
        
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == signPickerView {
            sign = pickerData[row].lowercased() as String
        } else if pickerView == customDatePicker {
            
            if component == 0 {
                day = daysArray[row].description
            } else if component == 1 {
                month = months[row]
            }
            date = "\(month) \(day)"
            
            
            print(date)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "MMMM dd"
            let newDate = dateFormatter.date(from: date)!
            print(newDate)
            
            getDate(date: newDate)
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if pickerView == customDatePicker {
            if component == 0 {
                return 45
            }
            return 140
        }
        
        return 414
        
    }
    
}

extension SettingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let name = textFeild.text ?? ""
        UserPreference.shared.updateName(name: name)
        settingsDelegate?.didChangeName(name: name)
    }
    
}


