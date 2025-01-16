//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error>
}

class WeatherService: WeatherServiceProtocol {
    private let apiKey = "6fcb04e860974265a8725126251601"
    private let baseURL = "https://api.weatherapi.com/v1/current.json"
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        guard NetworkMonitor.shared.isConnected else {
            return Fail(error: URLError(.notConnectedToInternet))
                .eraseToAnyPublisher()
        }

        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?key=\(apiKey)&q=\(cityEncoded)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


struct SearchResult: Identifiable, Codable {
    var id = UUID()
    let name: String
    let region: String
    let country: String
    let iconURL: String
    let temp_c: Double
}
