//
//  AccuWeatherCurrentConditions.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 24.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation

struct AccuWeatherCurrentConditions: Codable {
        
        let localObservationDateTime: String
        let epochTime: Int
        let weatherText: String
        let weatherIcon: Int
        let hasPrecipitation: Bool
        let precipitationType: String?
        let isDayTime: Bool
        let temperature: [String : AccuWeatherTemperatureData]
    
    func temperature(for unit: WeatherUnit) -> Double {
        switch unit {
        case .fahrenheit:
            return temperature["Imperial"]!.value
        case .celsius:
            return temperature["Metric"]!.value
        }
    }
    
        enum CodingKeys: String, CodingKey {
            case epochTime = "EpochTime"
            case weatherText = "WeatherText"
            case weatherIcon = "WeatherIcon"
            case hasPrecipitation = "HasPrecipitation"
            case precipitationType = "PrecipitationType"
            case isDayTime = "IsDayTime"
            case temperature = "Temperature"
            case localObservationDateTime = "LocalObservationDateTime"
        }
    
    }



enum WeatherUnit: Int {
    case celsius
    case fahrenheit
}
