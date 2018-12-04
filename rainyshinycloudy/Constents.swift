//
//  Constents.swift
//  rainyshinycloudy
//
//  Created by AIR on 14.11.2018.
//  Copyright © 2018 AIR. All rights reserved.
//

import Foundation

let BASE_URL = "https://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
//let API_KEY = "42a1771a0b787bf12e734ada0cfc80cb"
let API_KEY = "b1b15e88fa797225412429c1c50c122a1"

typealias DownloadComplete = () -> ()
//
//let CURRENT_WEATHER_URL: String = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitud!)\(APP_ID)\(API_KEY)"

let CURRENT_WEATHER_URL: String = "\(BASE_URL)\(LATITUDE)\(20.0)\(LONGITUDE)\(20.0)\(APP_ID)\(API_KEY)"
//let FORECAST_URL: String = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitud!)&cnt=10&mode=json&appid=5d4373766e6a79349b7200a78b6053e8"
let FORECAST_URL: String = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1"


