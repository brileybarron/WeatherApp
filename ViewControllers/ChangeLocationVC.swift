//
//  ChangeLocationVC.swift
//  WeatherApp
//
//  Created by Briley Barron on 11/15/18.
//  Copyright © 2018 Briley Barron. All rights reserved.
//

import UIKit

class ChangeLocationVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    func retrieveGeocodingData(searchAddress: String) {
        APIManager.getCoordinates(for: searchAddress) { geocodingData, error in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                print("error retrieving geocoding data")
                return
            }
            
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                self.retrieveWeatherData(latitude: recievedData.latitude, longitude: recievedData.longitude)
            } else {
                self.handleError()
                print("didn't retrieve data")
                return
            }
        }
    }
    
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        APIManager.getWeather(at: (latitude, longitude)) { weatherData, error in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                print("error retieving weather")
                return
            }
            
            if let recievedData = weatherData {
                self.weatherData = recievedData
                self.performSegue(withIdentifier: "unwindSegue", sender: self)
            } else {
                self.handleError()
                print("didn't recieve weather data")
                return
            }
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            print("not searching")
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherVC,
            let recievedGeocodingData = geocodingData,
            let retrievedWeatherData = weatherData {
            destinationVC.displayWeatherData = retrievedWeatherData
            destinationVC.displayGeocodingData = recievedGeocodingData
        }
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


