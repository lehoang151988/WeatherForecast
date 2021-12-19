//
//  WeatherService.swift
//  WeatherForecast
//
//  Created by Hoang Le on 18/12/2021.
//

import Foundation
import Alamofire

protocol IWeatherService {
    func downloadForecastData(forCity city: String, completed: @escaping WeatherDataCompletion)
}

class WeatherService: IWeatherService {
    func downloadForecastData(forCity city: String, completed: @escaping WeatherDataCompletion) {
        guard let forecastURL = URL(string: "\(FORECAST_CITY_URL)\(city)") else { return }
        Alamofire.request(forecastURL).responseJSON { response in
            if let error = response.error {
                completed(nil, error)
                return
            }
            
            let result = response.result
            var forecasts = [Forecast]()
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        forecasts.append(forecast)
                    }
                }
            }
            completed(forecasts, nil)
        }
    }
}
