//
//  ViewController.swift
//  WeatherApp
//
//  Created by Briley Barron on 11/14/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherVC: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\(displayWeatherData.temperature)º"
            highTempLabel.text = "\(displayWeatherData.highTemperature)º"
            lowTempLabel.text = "\(displayWeatherData.lowTemperature)º"
        }
    }

    @IBAction func unwindToWeatherVC (segue: UIStoryboardSegue) {}
    
    var displayGeocodingData: GeocodingData! {
        didSet {
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let latitude = 37.8267
        let longitude = -122.4233
        
        APIManager.getWeather(at: (latitude, longitude)) { weatherData, error in
            if let receivedData = weatherData {
                self.displayWeatherData = receivedData
            }
            
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
}

