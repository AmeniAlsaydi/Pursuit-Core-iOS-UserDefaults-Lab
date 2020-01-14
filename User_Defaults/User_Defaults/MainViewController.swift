//
//  MainViewController.swift
//  User_Defaults
//
//  Created by Amy Alsaydi on 1/13/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var horoscopeLabel: UILabel!
    
    var sign = UserPreference.shared.getSign()
    var name = UserPreference.shared.getName()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SettingViewController else {return}
        
        vc.settingsDelegate = self
    }
    
    func updateUI() {
        welcomeLabel.text = "Hello \(name?.capitalized ?? "")!"
        
        APIClient.getHoroscope(sign: sign) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let horoscope):
                DispatchQueue.main.async {
                    self.signLabel.text = horoscope.sunsign
                    self.horoscopeLabel.text = horoscope.horoscope
                }
            }
        }
        
    }
}

extension MainViewController: SettingDelegate {
    func didChangeName(name: String) {
        welcomeLabel.text = "Hello \(name.capitalized)!"
    }
    
    func didChangeSign(sign: String) {
        APIClient.getHoroscope(sign: sign) { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let horoscope):
                DispatchQueue.main.async {
                    self.signLabel.text = horoscope.sunsign
                    self.horoscopeLabel.text = horoscope.horoscope
                }
            }
        }

    }
    
    
}
