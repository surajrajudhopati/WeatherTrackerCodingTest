//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import Foundation

protocol LocalStorageServiceProtocol {
    func saveCity(_ city: String)
    func getSavedCity() -> String?
}

class LocalStorageService: LocalStorageServiceProtocol {
    private let savedCityKey = "savedCityKey"

    func saveCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: savedCityKey)
    }

    func getSavedCity() -> String? {
        UserDefaults.standard.string(forKey: savedCityKey)
    }
}
