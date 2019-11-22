//
//  FirstViewController.swift
//  Skillbox_m13
//
//  Created by Kravchuk Sergey on 24.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK - Outlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var hourlyForecastCollectionView: UICollectionView!
    @IBOutlet weak var dailyForecastTableView: UITableView!
    
    // MARK - Helpers
    let networkHelper = NetworkHelper()

    // MARK - State
    var currentWeather: AccuWeatherCurrentConditions? { didSet { updateCurrentWeatherUI() } }
    var unit: WeatherUnit = .celsius {
        didSet {
            updateCurrentWeatherUI()
            fetchHourlyForecast()
            fetchDailyForecast()
        }
    }
    var hourlyForecast: [AccuWeatherHourlyForecast]? {
        didSet {
            updateHourlyForecastUI()
        }
    }
    
    var dailyForecast: [AccuWeatherDailyForecast]? {
        didSet {
            updateDailyForecastUI()
        }
    }
    
    // MARK - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyForecastTableView.tableFooterView = UIView()
        
        hourlyForecastCollectionView.dataSource = self
        dailyForecastTableView.dataSource = self
        
        fetchCurrentWeather()
        fetchHourlyForecast()
        fetchDailyForecast()
    }

    
    // MARK - UI update
    private func updateCurrentWeatherUI() {
        guard let currentWeather = currentWeather else { return }
        
        cityLabel.text = "Moscow"
        
        weatherDescriptionLabel.text = currentWeather.weatherText
        
        let temperature = currentWeather.temperature(for: unit)
        
        temperatureLabel.text = "\(temperature)º"
        
    }
    
    func updateHourlyForecastUI() {
        hourlyForecastCollectionView.reloadData()
    }
    
    func updateDailyForecastUI() {
        dailyForecastTableView.reloadData()
    }
    
    // MARK - Data fetch
    
    private func fetchCurrentWeather() {
        networkHelper.fetchCurrentWeather() { [weak self] accuCurrentWeather in
            DispatchQueue.main.async {
                self?.currentWeather = accuCurrentWeather
            }
        }
    }
    
    private func fetchHourlyForecast() {
        
        networkHelper.fetchHourlyForecast(metric: unit == .celsius) {[weak self] forecastData in
            DispatchQueue.main.async {
                self?.hourlyForecast = forecastData
            }
        }
        
    }
    
    private func fetchDailyForecast() {
        networkHelper.fetchDailyForecast(metric: unit == .celsius) { [weak self] forecastData in
            DispatchQueue.main.async {
                self?.dailyForecast = forecastData
            }
        }
    }
    
    // MARK - Actions
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        fetchCurrentWeather()
        fetchHourlyForecast()
        fetchDailyForecast()
    }
    @IBAction func unitChanged(_ sender: UISegmentedControl) {
        unit = WeatherUnit(rawValue: sender.selectedSegmentIndex)!
    }
    
    
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyForecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = hourlyForecastCollectionView.dequeueReusableCell(withReuseIdentifier: "HourlyForecastCell", for: indexPath) as! HourlyForecastCell
        
        cell.update(with: hourlyForecast![indexPath.item])
        
        return cell
    }
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyForecastTableView.dequeueReusableCell(withIdentifier: "DailyForecastCell", for: indexPath) as! DailyForecastCell
        
        cell.update(with: dailyForecast![indexPath.row])
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dailyForecast?.count ?? 0
    }
}
