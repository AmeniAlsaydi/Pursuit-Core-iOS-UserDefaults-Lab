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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SettingViewController else {return}
        
        vc.settingsDelegate = self
    }
    
    func updateUI() {
        
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
