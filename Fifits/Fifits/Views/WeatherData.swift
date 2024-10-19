//
//  WeatherData.swift
//  Fifits
//
//  Created by Lemeng Wang on 10/19/24.
//

import Foundation
import CoreLocation

struct WeatherData {
    let locationName: String
    let temperature: Double
    let condition: String
}

struct WeatherResponse: Codable {
    let name: String
    let main: MainWeather
    let weather: [Weather]
}

struct MainWeather: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    
}
