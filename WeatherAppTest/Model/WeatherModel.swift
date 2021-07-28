//
//  WeatherModel.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import Foundation
import RealmSwift

final class WeatherModel: Object {
    @Persisted var conditionId: Int = 0
    @Persisted var cityName: String = ""
    @Persisted var temperature: Double = 0.0
    
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
    convenience init(weatherData: WeatherData) {
        self.init()
        conditionId = weatherData.weather[0].id
        cityName = weatherData.name
        temperature = weatherData.main.temp
    }
}
