//
//  AccuWeatherDaylyForecast.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 28.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation
struct AccuWeatherDailyForecast {
    let epochDate: Int
    let iconPhrase: String
    let minTemperature: AccuWeatherTemperatureData
    let maxTemperature: AccuWeatherTemperatureData
    
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
    
    init?(data: NSDictionary) {
        
        if let epochDate = data.value(forKey: "EpochDate") as? Int,
            let iconPhrase = data.value(forKeyPath: "Day.IconPhrase") as? String,
            let minTemperatureData = data.value(forKeyPath: "Temperature.Minimum") as? NSDictionary,
            let maxTemperatureData = data.value(forKeyPath: "Temperature.Maximum") as? NSDictionary,
            let minTemperature = AccuWeatherTemperatureData(data: minTemperatureData),
            let maxTemperature = AccuWeatherTemperatureData(data: maxTemperatureData)
        {
         
            self.epochDate = epochDate
            self.iconPhrase = iconPhrase
            self.minTemperature = minTemperature
            self.maxTemperature = maxTemperature
            
        } else {
            return nil
        }
    }
}
