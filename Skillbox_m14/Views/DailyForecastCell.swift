//
//  DailyForecastCell.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 28.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class DailyForecastCell: UITableViewCell {

    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    private static let formatter: DateFormatter = {
        let fmtr = DateFormatter()
        fmtr.dateFormat = "EEEE"
        return fmtr
    }()
    
    func update(with forecast: AccuWeatherDailyForecast) {
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.epochDate))
        
        weekdayLabel.text = DailyForecastCell.formatter.string(from: date)
        maxTemperatureLabel.text = "\(forecast.maxTemperature.value)"
        minTemperatureLabel.text = "\(forecast.minTemperature.value)"
        
        weatherLabel.text = forecast.icon
        
    }
    
    
    
}
