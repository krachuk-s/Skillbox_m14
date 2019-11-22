//
//  AccuWeatherHourlyForecast.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 27.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation
struct AccuWeatherHourlyForecast: Codable {
    var epochTime: Int
    var iconPhrase: String?
    var isDaylight: Bool
    var hasPrecipitation: Bool
    var temperature: AccuWeatherTemperatureData
    
    var icon: String {
        
        switch iconPhrase {
        case "Intermittent clouds", "Mostly clear":
            return "🌤"
        case "Partly cloudy":
            return "⛅️"
        case "Mostly cloudy":
            return "🌥"
        case "Cloudy", "Dreary":
            return "☁️"
        case "Showers":
            return "🌧"
        case "Snow":
            return "❄️"
        case "Flurries":
            return "🌨"
        case "Sunny":
            return "☀️"
        default:
            print(iconPhrase)
            return "☀️"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case epochTime = "EpochDateTime"
        case iconPhrase = "IconPhrase"
        case isDaylight = "IsDaylight"
        case hasPrecipitation = "HasPrecipitation"
        case temperature = "Temperature"
    }
}
