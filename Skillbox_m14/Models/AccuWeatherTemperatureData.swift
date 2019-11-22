//
//  AccuWeatherTemperatureData.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 27.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation

struct AccuWeatherTemperatureData: Codable {
    let value: Double
    let unit: String
    let unitType: Int
    
    init?(data: NSDictionary) {
        if let value = data.value(forKey: "Value") as? Double,
            let unit = data.value(forKey: "Unit") as? String,
            let unitType = data.value(forKey: "UnitType") as? Int {
            
            self.value = value
            self.unit = unit
            self.unitType = unitType
            
        } else {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}
