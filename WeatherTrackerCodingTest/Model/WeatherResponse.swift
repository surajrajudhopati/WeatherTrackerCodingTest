//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather

    struct Location: Codable {
        let name: String
        let region: String
        let country: String
    }

    struct CurrentWeather: Codable {
        let temp_c: Double
        let condition: Condition
        let humidity: Int
        let uv: Double
        let feelslike_c: Double

        struct Condition: Codable {
            let text: String
            let icon: String
        }
    }
}
