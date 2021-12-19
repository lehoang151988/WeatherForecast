//
//  Constants.swift
//  WeatherForecast
//
//  Created by Hoang Le on 16/12/2021.
//

import Foundation

//\(Location.sharedInstance.latitude!)
//\(Location.sharedInstance.longitude!)
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
//let CITY = "&q=\(Location.sharedInstance.cityName!)"
let APP_ID = "&appid="
let API_KEY = "60c6fbeb4b93ac653c492ba806fc346d"

typealias  downloadComplete = () -> ()
typealias WeatherDataCompletion = ([Forecast]?, Error?) -> Void

//let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"
//let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(Location.sharedInstance.cityName!)&cnt=14&appid=60c6fbeb4b93ac653c492ba806fc346d"
let FORECAST_WEATHER_ICON_URL = "http://openweathermap.org/img/wn/"
let ICON_TYPE = "@2x.png"
let FORECAST_CITY_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?cnt=14&appid=60c6fbeb4b93ac653c492ba806fc346d&q="


