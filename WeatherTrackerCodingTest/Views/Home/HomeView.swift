//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showSearch = false
    @State private var searchText = ""

    var body: some View {
        VStack {
            // Search Bar
            HStack {
                HStack {
                    TextField("Search Location", text: $searchText)
                        .onSubmit {
                            showSearch = true
                        }
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.top, 20)

            Spacer()

            if let weather = viewModel.weather {
                WeatherCardView(weather: weather)
            } else {
                VStack {
                    Text("No City Selected")
                        .font(.system(size: 30))
                        .bold()
                    Text("Please Search For A City")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                }
            }

            Spacer()
        }
        .onAppear {
            viewModel.loadSavedCityWeather()
        }
        .sheet(isPresented: $showSearch) {
            SearchView(query: $searchText) { selectedCity in
                viewModel.fetchWeather(for: selectedCity)
            }
        }
    }
}

struct InfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .bold()
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}
