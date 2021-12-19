//
//  WeatherPresenter.swift
//  WeatherForecast
//
//  Created by Hoang Le on 18/12/2021.
//

import Foundation
import Alamofire

protocol WeatherViewable: class {
    func updateMainUI(forecasts: [Forecast])
}

class WeatherPresenter {
    unowned var viewable: WeatherViewable
    let weatherService: IWeatherService!
    
    init(viewable: WeatherViewable, service: IWeatherService) {
        self.viewable = viewable
        self.weatherService = service
    }
    
    func searchWeather(_ text: String) {
        weatherService.downloadForecastData(forCity: text) { [weak self] (forecasts, error)  in
            self?.viewable.updateMainUI(forecasts: forecasts ?? [])
        }
    }
}
