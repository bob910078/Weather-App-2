//
//  SwiftyJSONWeatherParser.swift
//  Weather-App-2
//
//  Created by Bob Chang on 2019/5/17.
//  Copyright © 2019 mitchell hudson. All rights reserved.
//

import Foundation

class SwiftyJSONWeatherParser {
    
    let jsonData: JSON
    
    init?(JSONData data: Data) {
        if let json = try? JSON(data: data) {
            self.jsonData = json
        } else {
            return nil
        }
    }
    
    var statusCode: Int {
        // Get the cod code: 401 Unauthorized, 404 file not found, 200 Ok!
        // ! OpenWeatherMap returns 404 as a string but 401 and 200 are Int!?
        var status = 0
        
        if let cod = jsonData["cod"].int {
            status = cod
        } else if let cod = jsonData["cod"].string {
            status = Int(cod)!
        }
        
        return status
    }
    
    var weatherData: Weather? {
        
        // everything is ok get the weather data from the json data.
        let _ = jsonData["coord"]["lon"].double!
        let _ = jsonData["coord"]["lat"].double!
        let temp = jsonData["main"]["temp"].double!
        let tempMin = jsonData["main"]["temp_min"].double!
        let tempMax = jsonData["main"]["temp_max"].double!
        let humidity = jsonData["main"]["humidity"].double!
        let pressure = jsonData["main"]["pressure"].double!
        let name = jsonData["name"].string!
        let desc = jsonData["weather"][0]["description"].string!
        let icon = jsonData["weather"][0]["icon"].string!
        let clouds = jsonData["clouds"]["all"].double!
        let windSpeed = jsonData["wind"]["speed"].double!
        
        return Weather( cityName: name,
                        temp: temp,
                        description: desc,
                        icon: icon,
                        clouds: clouds,
                        tempMin: tempMin,
                        tempMax: tempMax,
                        humidity: humidity,
                        pressure: pressure,
                        windSpeed: windSpeed )
    }
    
    
    
    
}
