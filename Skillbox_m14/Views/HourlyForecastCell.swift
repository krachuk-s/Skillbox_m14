//
//  HourlyForecastCell.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 27.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class HourlyForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static var timeFormatter: DateFormatter = {
        let fmtr = DateFormatter()
        fmtr.dateFormat = "HH"
        return fmtr
    }()
    
    func update(with forecastData: AccuWeatherHourlyForecast) {
        
        let temperature = forecastData.temperature.value
        
        weatherLabel.text = forecastData.icon
        temperatureLabel.text = "\(temperature)º"
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecastData.epochTime))
        
        hourLabel.text = HourlyForecastCell.timeFormatter.string(from: date)
        
    }
    
}
