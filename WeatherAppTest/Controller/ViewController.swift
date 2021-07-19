//
//  ViewController.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var items: Results<TaskList>!
    
    let emptyCity = WeatherModel()
    var netWorking = NetWorking()
    var cities = [WeatherModel]()
    let citiesArray = ["Moscow", "Minsk", "Vilnius"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        if cities.isEmpty {
            cities = Array(repeating: emptyCity, count: citiesArray.count)
        }
//        addCities()
//        getItems()
                addCities()
        print(realm.configuration.fileURL!)
        
    }
    
//    func getItems() {
//        items = realm.objects(TaskList.self)
//
//        self.collectionView.reloadData()
//    }
    
    func getCitiesWeather(citiesArray: [String], complitionHandler: @escaping(Int,WeatherModel) -> Void) {
        for (index, item) in citiesArray.enumerated() {
            netWorking.fetchWeather(city: item) { weatherModel in
                complitionHandler(index, weatherModel)
            }
        }
    }
    
    func addCities() {
        getCitiesWeather(citiesArray: citiesArray) { index, weather in
            self.cities[index] = weather
            self.cities[index].cityName = self.citiesArray[index]
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension ViewController: UICollisionBehaviorDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCell
        
        
                var weather = WeatherModel()
                weather = cities[indexPath.row]
                cell?.configure(weather: weather)
        
        return cell ?? PhotoCell()
    }
    
    
}
