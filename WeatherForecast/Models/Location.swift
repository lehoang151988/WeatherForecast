//
//  Location.swift
//  WeatherForecast
//
//  Created by Hoang Le on 16/12/2021.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    var latitude: Double!
    var longitude: Double!
    var cityName: String!
    
    private init () {}
}
