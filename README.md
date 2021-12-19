# WeatherForecast

## Objective:
This is a simple Demo project which aims to display weather information using MVP pattern in Swift. A fun app made with to demonstrate some examples of **clean architecture**, **SOLID principles** code organisation, loose coupling, **unit testing** and some of the best practices used in modern iOS programming using `Swift`.

## App Goal:
 - This project was intended to work as a  weather information demo projects for iOS using Swift.

## Implementation:
 - The demo uses the [Openweathermap API](https://api.openweathermap.org) as an excuse to have a nice use-case, because querying a WebService API is asynchronous by nature and is thus a good example for showing how It can be useful .
 - Use a UITableViewController to display weather information of city.
 - Provide a way to add more cities using another modal view controller which includes a search functionality to find a city by name
 - Each cell should display the info: Date, Temperature, Pressure, Humidity and Description on the left, weather icon on the right.
 - Get real time weather information

## Installation
- Xcode **11.3**(required)
- Clean `/DerivedData` folder if any
- Run the pod install `pod install`
- Then clean and build the project in Xcode

## 3rd Party Libraries
 - **`Alamofire`** - is an HTTP networking library written in Swift.
 - **`SnapKit`** - is a DSL to make Auto Layout easy on both iOS and OS X. 

