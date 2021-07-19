//
//  WeatherData.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
