//
//  NetworkServiceInterface.swift
//  Weather-App-2
//
//  Created by Bob Chang on 2019/5/16.
//  Copyright © 2019 mitchell hudson. All rights reserved.
//

import Foundation
import CoreLocation

typealias City = String
typealias Location = CLLocation

protocol WeatherServiceInterface {
    var delegate: WeatherServiceDelegate? { get set }
    func getWeather(for location: Location)
    func getWeather(for city: City)
}

protocol OpenWeatherMapService: WeatherServiceInterface {
    var appid: String { get }
    var openweathermapURL: URL { get }
}

extension OpenWeatherMapService {
    
    var appid: String {
        return "05a1f2ada9a00ef2a30138d26e5814e4"
    }
    
    var openweathermapURL: URL {
        return URL.init(string: "http://api.openweathermap.org/data/2.5/weather")!
    }
    
}
