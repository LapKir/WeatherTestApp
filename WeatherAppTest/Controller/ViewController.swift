//
//  ViewController.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import UIKit
import RealmSwift

final class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var items: [WeatherModel] = []

    let citiesArray = ["Moscow", "Minsk", "Vilnius"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addCities()
    }
    
    func getCitiesWeather(citiesArray: [String], complitionHandler: @escaping (WeatherModel?) -> Void) {
        for item in citiesArray {
            WeatherFetcher.load(city: item) { weatherModel in
                complitionHandler(weatherModel)
            }
        }
    }
    
    func addCities() {
        items = []
        getCitiesWeather(citiesArray: citiesArray) { weather in
            if let model = weather {
                self.items.append(model)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    WeatherFetcher.fixUpdateTime()
                }
            }
        }
    }
}

extension ViewController: UICollisionBehaviorDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCell
        
        var weather = WeatherModel()
        weather = items[indexPath.row]
        cell?.configure(weather: weather)
        
        return cell ?? PhotoCell()
    }
}
