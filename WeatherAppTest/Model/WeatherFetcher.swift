//
//  WeatherFetcher.swift
//  WeatherAppTest
//
//  Created by Cyril on 19.07.21.
//

import Foundation

struct WeatherFetcher {
    private static let updateTimeKey = "UpdateTimeKey"

    static func load(city: String, completion: @escaping (WeatherModel?) -> ()) {
        if shouldUpdate() {
            let networkManager = NetWorking()

            networkManager.fetchWeather(city: city) { model in
                DispatchQueue.main.async {
                    DataBaseManager.shared().write(model)
                }
                completion(model)
            }
        } else {
            DataBaseManager.shared().fetch(WeatherModel.self) { models in
                completion(models.first(where: { $0.cityName == city }))
            }
        }
    }

    static func fixUpdateTime() {
        let currentMillis = NSDate().timeIntervalSince1970
        let nextUpdateTime = currentMillis + 5 * 60

        UserDefaults.standard.setValue(nextUpdateTime, forKey: updateTimeKey)
    }

    static func shouldUpdate() -> Bool {
        let currentMillis = NSDate().timeIntervalSince1970
        guard let updateDeadline = UserDefaults.standard.value(forKey: updateTimeKey) as? TimeInterval else {
            return true
        }
        return currentMillis > updateDeadline
    }
}
