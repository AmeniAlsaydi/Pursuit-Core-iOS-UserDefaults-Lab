//
//  HoroscopeDates.swift
//  User_Defaults
//
//  Created by Amy Alsaydi on 1/14/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//


// Reference: David

import Foundation

enum HoroscopeDates: String {
        case AriesStart = "03/21"
        case AriesEnd = "04/19"
        case TaurusStart = "04/20"
        case TaurusEnd = "05/20"
        case GeminiStart = "05/21"
        case GeminiEnd = "06/20"
        case CancerStart = "06/21"
        case CancerEnd = "07/22"
        case LeoStart = "07/23"
        case LeoEnd = "08/22"
        case VirgoStart = "08/23"
        case VirgoEnd = "09/22"
        case LibraStart = "09/23"
        case LibraEnd = "10/22"
        case ScorpioStart = "10/23"
        case ScorpioEnd = "11/21"
        case SagittariusStart = "11/22"
        case SagittariusEnd = "12/21"
            case CapricornStart = "12/22"
            case CapriocornEndYear = "12/31"
            case CapricornStartYear = "01/01"
            case CapricornEnd = "01/19"
        case AquariusStart = "01/20"
        case AquariusEnd = "02/18"
        case PiscesStart = "02/19"
        case PiscesEnd = "03/20"
    
    func date() -> Date {
        let horoscopeDate = self.rawValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        let date = dateFormatter.date(from:horoscopeDate)!
        return date
    }
}
