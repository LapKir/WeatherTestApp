//
//  PhotoCell.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import UIKit
import RealmSwift

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    let realm = try! Realm()
    
    func configure(weather: WeatherModel) {
        self.cityLabel.text = weather.cityName
        self.temperatureLabel.text = weather.temperatureString
        self.conditionImage.image = UIImage(systemName: weather.conditionName)
    }

    
}
