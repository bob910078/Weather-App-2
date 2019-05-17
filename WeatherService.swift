//
//  WeatherService.swift
//  Weather-App-Example
//
//  Created by mitchell hudson on 10/6/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//


/* 

 The Weather Service class retrieves weather data from OpenWeatherMap.
 
 This class works with JSON using SwiftyJSON, following the OpenWeatherMap API.
 
*/

// TODO: Add an enum for error codes. 
// TODO: Use an enum for weather icons.


import Foundation

class WeatherService: OpenWeatherMapService {
    
    var delegate: WeatherServiceDelegate?
    
    /// Formats an API call to the OpenWeatherMap service.
    ///
    /// - Parameter location: to retrieve weather data for that location.
    func getWeather(for location: Location) {
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        // Put together a URL With lat and lon
        let path = openweathermapURL.absoluteString + "?lat=\(lat)&lon=\(lon)&appid=\(appid)"
        
        getWeatherWithPath(path: path, completion: { (data, response, error) in
            self.handleWeatherResponse(data: data, response: response, error: error)
        })
    }
    
    /// Formats an API call to the OpenWeatherMap service.
    ///
    /// - Parameter city: Pass in a string in the form City Name, Country.
    func getWeather(for city: City) {
        
        let cityString: NSString = city as NSString
        if let cityEscaped = cityString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed) {
            let path = openweathermapURL.absoluteString + "?q=\(cityEscaped)&appid=\(appid)"
            getWeatherWithPath(path: path, completion: { (data, response, error) in
                self.handleWeatherResponse(data: data, response: response, error: error)
            })
        }
        
    }
    
    /** This Method retrieves weather data from an API path. */
    private func getWeatherWithPath(path: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // Create a URL, Session, and Data task.
        let url = URL(string: path)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            #if DEBUG
            if let d = data, let t = String(data: d, encoding: String.Encoding.utf8) {
                print(t)
            }
            #endif
            
            completion(data, response, error)
        }
        
        // *** This starts the data session ***
        task.resume()
    }
    
    
    private func handleWeatherResponse(data: Data?, response: URLResponse?, error: Error?) {
        
        // Handle an HTTP status response.
        if let httpResponse = response as? HTTPURLResponse {
            print("*******")
            print(httpResponse.statusCode)
            print("*******")
        }
        
        
        guard let parser = SwiftyJSONWeatherParser(JSONData: data!) else {
            fatalError()
        }
        
        switch parser.statusCode {
        case 200:
            // Check the delegate has been set.
            if self.delegate != nil {
                // The Session runs on a background thread move back to the main queue
                // and pass the weather to our delegate.
                DispatchQueue.main.async(execute: {
                    self.delegate?.setWeather(weather: parser.weatherData!)
                })
            }
            
        case 404:
            // City not found
            if self.delegate != nil {
                DispatchQueue.main.async(execute: {
                    self.delegate?.weatherErrorWithMessage(message: "City not found")
                })
            }
            
        default:
            // Some other here?
            if self.delegate != nil {
                DispatchQueue.main.async(execute: {
                    self.delegate?.weatherErrorWithMessage(message: "Something went wrong?")
                })
            }
            
        }
        
    }
    
}
