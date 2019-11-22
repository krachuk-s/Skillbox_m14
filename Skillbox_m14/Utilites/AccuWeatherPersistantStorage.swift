//
//  AccuWeatherPersistantStorage.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 22.11.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation
struct AccuWeatherPersistantStorage {
    
    static func save(_ currentWeather: AccuWeatherCurrentConditions) {
        write(currentWeather, to: fileURL(for: currentWeatherPath))
    }
    
    static func load() -> AccuWeatherCurrentConditions? {
        return read(from: fileURL(for: currentWeatherPath))
    }
    
    static func save(_ dailyForecast: [AccuWeatherDailyForecast]) {
        write(dailyForecast, to: fileURL(for: dailyForecastsPath))
    }
    
    static func load() -> [AccuWeatherDailyForecast]? {
        return read(from: fileURL(for: dailyForecastsPath))
    }
    
    static func save(_ hourlyForecasts: [AccuWeatherHourlyForecast]) {
        write(hourlyForecasts, to: fileURL(for: hourlyForecastsPath))
    }
    
    static func load() -> [AccuWeatherHourlyForecast]? {
        return read(from: fileURL(for: hourlyForecastsPath))
    }
    
    private static func fileURL(for filename: String) -> URL {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        .appendingPathComponent(filename)
        .appendingPathExtension("json")
        return fileURL
    }
    
    private static func write<T: Codable>(_ info: T, to file: URL) {
        
        let data: Data
        do {
            try data = JSONEncoder().encode(info)
        } catch {
            print(error)
            return
        }
        
        do {
            try data.write(to: file, options: .atomic)
        } catch {
            print(error)
        }
        
    }
    
    private static func read<T: Codable>(from file: URL) -> T? {
        
        let data: Data
        
        do {
            try data = Data(contentsOf: file)
        } catch {
            print(error)
            return nil
        }
        
        let contents: T
        
        do {
            contents = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
        
        return contents
    }
    
    private static let currentWeatherPath: String = "current"
    private static let dailyForecastsPath = "dailyForecasts"
    private static let hourlyForecastsPath = "hourlyForecasts"
}
