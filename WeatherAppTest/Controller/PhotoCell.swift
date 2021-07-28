//
//  PhotoCell.swift
//  WeatherAppTest
//
//  Created by Cyril on 18.07.21.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    func configure(weather: WeatherModel) {
        self.cityLabel.text = weather.cityName
        self.temperatureLabel.text = weather.temperatureString
        self.conditionImage.image = UIImage(systemName: weather.conditionName)
    }
}
