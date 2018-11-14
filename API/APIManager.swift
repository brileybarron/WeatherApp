//
//  APIManager.swift
//  WeatherApp
//
//  Created by Briley Barron on 11/14/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIManager {
    
    
    static func getWeather(at location: Location, onComplete: @escaping (String?, Error?) -> Void) {
        let baseURL = "https://api.darksky.net/forecast/"
        let key = APIKey.darkSkySecret
        let url = "\(baseURL)\(key)/\(location.latitude),\(location.longitude)"
        
        //https://api.darksky.net/forecast/b8d19284004e1f8686c3780f53158414/,
        Alamofire.request(url).responseJSON { response in
            switch response.result{
            case .success(let value):
                onComplete("\(value)", nil)
            case .failure(let error):
                onComplete(nil, error)
            }
        }
    }
    
    
}
