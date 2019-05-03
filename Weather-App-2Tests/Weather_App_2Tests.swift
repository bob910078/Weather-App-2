//
//  Weather_App_2Tests.swift
//  Weather-App-2Tests
//
//  Created by Bob Chang on 2019/5/3.
//  Copyright © 2019 mitchell hudson. All rights reserved.
//

import XCTest
@testable import Weather_App_2

class Weather_App_2Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherStructTemperature300ConvertToCelsiusDegree() {
        
        // Given
        let sut = Weather(cityName: "txt",
                          temp: 300,
                          description: "txt",
                          icon: "txt",
                          clouds: 0,
                          tempMin: 0,
                          tempMax: 0,
                          humidity: 0,
                          pressure: 0,
                          windSpeed: 0)
        // When
        let output = sut.tempC
        // Then
        XCTAssertEqual(output, 300 - 273.15, accuracy: 0.001)
    }

}
