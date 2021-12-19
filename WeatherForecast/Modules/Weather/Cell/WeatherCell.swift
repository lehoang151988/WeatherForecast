//
//  WeatherCell.swift
//  WeatherForecast
//
//  Created by Hoang Le on 16/12/2021.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    
    func configureCell(forecast: Forecast) {
        let iconURL = URL(string: "\(FORECAST_WEATHER_ICON_URL)\(forecast.weatherIcon)\(ICON_TYPE)")
        weatherIcon.load(from: iconURL, animated: true)
        
        dayLabel.text = "Date: \(forecast.date)"
        dayTempLabel.text = "Average Temperature: \(forecast.dayTemp)°C"
        pressureLabel.text = "Pressure: \(forecast.pressure)"
        humidityLabel.text = "Humidity: \(forecast.humidity)%"
        weatherTypeLabel.text = "Description: \(forecast.weatherType)"
        applyAccessibility()
    }
}

// MARK: Accessibility
extension WeatherCell {
    func applyAccessibility() {
        weatherIcon.accessibilityTraits = UIAccessibilityTraits.image
        
        dayLabel.isAccessibilityElement = true
        dayLabel.accessibilityTraits = UIAccessibilityTraits.none
        dayLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dayLabel.adjustsFontForContentSizeCategory = true
        
        dayTempLabel.isAccessibilityElement = true
        dayTempLabel.accessibilityTraits = UIAccessibilityTraits.none
        dayTempLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dayTempLabel.adjustsFontForContentSizeCategory = true
        
        pressureLabel.isAccessibilityElement = true
        pressureLabel.accessibilityTraits = UIAccessibilityTraits.none
        pressureLabel.font = UIFont.preferredFont(forTextStyle: .body)
        pressureLabel.adjustsFontForContentSizeCategory = true
        
        humidityLabel.isAccessibilityElement = true
        humidityLabel.accessibilityTraits = UIAccessibilityTraits.none
        humidityLabel.font = UIFont.preferredFont(forTextStyle: .body)
        humidityLabel.adjustsFontForContentSizeCategory = true
        
        weatherTypeLabel.isAccessibilityElement = true
        weatherTypeLabel.accessibilityTraits = UIAccessibilityTraits.none
        weatherTypeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        weatherTypeLabel.adjustsFontForContentSizeCategory = true
    }
}
