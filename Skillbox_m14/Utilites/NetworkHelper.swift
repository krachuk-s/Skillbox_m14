//
//  NetworkHelper.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 27.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation

class NetworkHelper {
    
    func fetchCurrentWeather(comlpetion: @escaping (AccuWeatherCurrentConditions)->Void ) {
        
        URLSession.shared.dataTask(with: AccuWeatherAPI.currentWeatherURL) { data, urlResponse, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode([AccuWeatherCurrentConditions].self, from: data)
                    if let currentWeather = result.first {
                        comlpetion(currentWeather)
                    }
                } catch {
                    print(error)
                }
                
            } else if let error = error {
                print(error)
            }
        }.resume()
        
    }
    
    func fetchHourlyForecast(metric: Bool, comletion: @escaping ([AccuWeatherHourlyForecast]) -> Void) {
        
        URLSession.shared.dataTask(with: AccuWeatherAPI.hourlyForecastURL(metric: metric)) { data, urlResponse, error in
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let forecastData: [AccuWeatherHourlyForecast] =  try decoder.decode([AccuWeatherHourlyForecast].self, from: data)
                    comletion(forecastData)
                } catch {
                    print(error)
                }
                
            } else if let error = error {
                print(error)
            }
        }.resume()
        
    }
    
    func fetchDailyForecast(metric: Bool, completion: @escaping ([AccuWeatherDailyForecast]) -> Void) {
    
        URLSession.shared.dataTask(with: AccuWeatherAPI.dailyForecastURL(metric: metric)) { data, response, error in
            if let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                let forecastsData = jsonData.value(forKey: "DailyForecasts") as? [NSDictionary] {
                
                let forecasts: [AccuWeatherDailyForecast] = forecastsData.compactMap {
                    AccuWeatherDailyForecast(data: $0)
                }
                
                completion(forecasts)
                
            } else if let error = error {
                print(error)
            }
        }.resume()
    }
    
}
