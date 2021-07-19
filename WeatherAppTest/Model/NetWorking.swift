//
//  NetWorking.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import Foundation

struct NetWorking {
    
    func fetchWeather(city: String, completionHandler: @escaping (WeatherModel) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=02d200ec856ba7d91a9538050df02b12&units=metric&q=\(city)"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            if let weather = parseJSON(withData: data) {
                print(weather)
                completionHandler(weather)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            let weather = WeatherModel(weatherData: weatherData)
            return weather
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
