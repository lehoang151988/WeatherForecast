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
        weatherIcon.image = UIImage(named: forecast.weatherType)
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
    }
}
