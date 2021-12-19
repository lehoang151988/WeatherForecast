//
//  Forecast.swift
//  WeatherForecast
//
//  Created by Hoang Le on 16/12/2021.
//
import UIKit
import Alamofire

class Forecast {
    private var _date:String!
    private var _weatherType: String!
    private var _dayTemp: String!
    private var _pressure: String!
    private var _humidity: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var dayTemp: String {
        if _dayTemp == nil {
            _dayTemp = ""
        }
        return _dayTemp
    }
    
    var pressure: String {
        if _pressure == nil {
            _pressure = ""
        }
        return _pressure
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let max = temp["day"] as? Double {
                let kelvinToCelsiusPreDivison = max - 273.15
                let kelvinToCelsius = Double(round(10*kelvinToCelsiusPreDivison/10))
                self._dayTemp = "\(kelvinToCelsius)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let pressure = weatherDict["pressure"] as? Int {
            self._pressure = "\(pressure)"
        }
        
        if let humidity = weatherDict["humidity"] as? Int {
            self._humidity = "\(humidity)"
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
