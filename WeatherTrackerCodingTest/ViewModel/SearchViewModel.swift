//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchResults: [SearchResult] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var query: String = ""

    private let weatherService: WeatherServiceProtocol = WeatherService()
    private var cancellables = Set<AnyCancellable>()

    func searchCity() {
        isLoading = true
        errorMessage = nil

        weatherService.fetchWeather(for: query)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                        self?.errorMessage = "No network connection. Please check your internet."
                    } else {
                        self?.errorMessage = "Failed to search city, please enter valid city name"
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weatherResponse in
                self?.searchResults = [
                    SearchResult(
                        name: weatherResponse.location.name,
                        region: weatherResponse.location.region,
                        country: weatherResponse.location.country,
                        iconURL: "https:\(weatherResponse.current.condition.icon)",
                        temp_c: weatherResponse.current.temp_c
                    )
                ]
            })
            .store(in: &cancellables)
    }
}
