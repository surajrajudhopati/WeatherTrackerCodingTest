//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var weather: WeatherResponse?

    private let weatherService: WeatherServiceProtocol = WeatherService()
    private let localStorage: LocalStorageServiceProtocol = LocalStorageService()
    private var cancellables = Set<AnyCancellable>()

    func loadSavedCityWeather() {
        if let city = localStorage.getSavedCity() {
            fetchWeather(for: city)
        }
    }

    func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to fetch weather: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weatherResponse in
                self?.weather = weatherResponse
            })
            .store(in: &cancellables)
    }
}
