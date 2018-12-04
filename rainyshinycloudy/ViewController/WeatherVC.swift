//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by AIR on 07.10.2018.
//  Copyright © 2018 AIR. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentlocation = CLLocation()
    
    var weatherView = WeatherView()
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts: [Forecast] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var mainView: WeatherView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
  
        
        currentWeather = CurrentWeather()
//        forecast = Forecast(weatherDict: <#Dictionary<String, AnyObject>#>)
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
    }
    
    func updateMainUI(){
        
        mainView.dateLabel.text = currentWeather.date
        mainView.currentTempLabel.text = "\(currentWeather.currentTemp)°"
        mainView.currentWeatherLabel.text = currentWeather.weatherType
        mainView.locationLabel.text = currentWeather.cityName
        print(currentWeather.weatherType)
        mainView.currentWeatherImage.image = UIImage(named: currentWeather.weatherType)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentlocation = locationManager.location!
            Location.sharedInstance.latitude = currentlocation.coordinate.latitude
            Location.sharedInstance.longitud = currentlocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            
            .responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
}
//extension WeatherVC: UITableViewDelegate {
//}


extension WeatherVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? weatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
             return cell
        } else {
                return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

