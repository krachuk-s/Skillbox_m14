//
//  AccuWeatherAPI.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 30.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation

struct AccuWeatherAPI {
    static var cityKey = "293149" // "294021" //"293149"//
    static let hostName = "dataservice.accuweather.com"
    static let apiKey = "sdxaa1iVNZNErcm0B3wgbUzPgxWWSpuR"
    
    static var currentWeatherURL: URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = hostName
        components.path = "/currentconditions/v1/\(cityKey)"
        components.queryItems = [URLQueryItem(name: "apikey", value: apiKey)]
        return components.url!
    }
    
    static func hourlyForecastURL(metric: Bool) -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = hostName
        components.path = "/forecasts/v1/hourly/12hour/\(cityKey)"
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "metric", value: "\(metric)")
        ]
        return components.url!
    }
    
    static func dailyForecastURL(metric: Bool) -> URL {
        var components = URLComponents()
        components.scheme = "http"
        components.host = hostName
        components.path = "/forecasts/v1/daily/5day/\(cityKey)"
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "metric", value: "\(metric)")
        ]
        return components.url!
    }
}

