//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import SwiftUI

struct WeatherCardView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 16) {
            // Weather Icon
            AsyncImage(url: URL(string: "https:\(weather.current.condition.icon)")) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)

            // City Name and Temperature
            VStack(spacing: 8) {
                HStack {
                    Text(weather.location.name)
                        .font(.system(size: 40))
                        .bold()

                    Image(systemName: "location.fill")
                        .foregroundColor(.black)
                }

                Text("\(Int(weather.current.temp_c))°")
                    .font(.system(size: 50))
                    .bold()
            }

            // Additional Weather Info in a Single Grey Background
            HStack(spacing: 20) {
                InfoCard(title: "Humidity", value: "\(weather.current.humidity)%")
                InfoCard(title: "UV", value: "\(Int(weather.current.uv))")
                InfoCard(title: "Feels Like", value: "\(Int(weather.current.feelslike_c))°")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
        .padding()
    }
}
