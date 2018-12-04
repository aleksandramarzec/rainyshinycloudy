//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by AIR on 14.11.2018.
//  Copyright © 2018 AIR. All rights reserved.
//

import UIKit
import Alamofire


class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatheType: String!
    var _currentTemp: Double!
    
    
    var cityName:String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
        }
    
    var date:String {
        if _date == nil {
            _date = ""
        }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
//    dateFormatter.timeSyle = .none
        let currentDate = dateFormatter.string(from:Date())
    self._date = "Today. \(currentDate)"
    return _date
    }
    var weatherType:String {
        if _weatheType == nil {
            _weatheType = ""
        }
        return _weatheType
        }
    var currentTemp:Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
}
    func downloadWeatherDetails(completed:DownloadComplete) {
        //alamofire
        print(CURRENT_WEATHER_URL)
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
            let result = response.result
            
            if let dict = result.value as?  Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                if let weather = dict["weather"] as?  [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatheType = main
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTermerature = main["temp"] as? Double {
                        let kelvinToFarenheitPreDivision = (currentTermerature * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                        self._currentTemp = kelvinToFarenheit
                        print(self._currentTemp)
                    }
                }
            }
        }
        completed()
    }
}



