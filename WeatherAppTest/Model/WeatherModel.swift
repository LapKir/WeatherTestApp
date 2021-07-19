//
//  WeatherModel.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import Foundation

struct WeatherModel {
    var conditionId: Int = 0
    var cityName: String = ""
    var temperature: Double = 0.0
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    init?(weatherData: WeatherData) {
        conditionId = weatherData.weather[0].id
        cityName = weatherData.name
        temperature = weatherData.main.temp
    }
    init() {
    }
}
