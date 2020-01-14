//
//  UserPreference.swift
//  User_Defaults
//
//  Created by Amy Alsaydi on 1/13/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct UserPreferenceKey {
    static let sign = "Sign"
    static let name = "Name"
}

class UserPreference {
    
    private init() {}
    
    static let shared = UserPreference()
    
    func updateSign(sign: String) {
        
        UserDefaults.standard.set(sign, forKey: UserPreferenceKey.sign)
    }
    
    func getSign() -> String {
        guard let userSign = UserDefaults.standard.object(forKey: UserPreferenceKey.sign) as? String  else {
            return "gemini"
        }
        return userSign
    }

}
