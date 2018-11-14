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

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let latitude = 37.8267
        let longitude = -122.4233
        
        APIManager.getWeather(at: (latitude, longitude)) { value, error in
            guard let value = value else {
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("sorry error, no description")
                }
                self.view.backgroundColor = .red
                return
            }
            print(value)
            self.view.backgroundColor = .green
        }
    }
    
    
}

