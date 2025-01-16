//
//  Untitled.swift
//  WeatherTrackerCodingTest
//
//  Created by Suraj Raju Dhopati on 1/16/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = SearchViewModel()
    @Binding var query: String
    var onCitySelected: (String) -> Void

    var body: some View {
        VStack {
            // Search Bar
            HStack {
                HStack {
                    TextField("Enter city name", text: $query)
                        .onSubmit {
                            viewModel.query = query
                            viewModel.searchCity()
                        }

                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
            .padding()

            // Loading State
            if viewModel.isLoading {
                ProgressView("Searching...")
            }
            // Error State
            else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            // Results State
            else if !viewModel.searchResults.isEmpty {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.searchResults, id: \.id) { result in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    // City Name
                                    Text(result.name)
                                        .font(.system(size: 30))
                                        .bold()

                                    // Temperature
                                    Text("\(Int(result.temp_c))°")
                                        .font(.system(size: 70))
                                        .bold()
                                        .foregroundColor(.black)
                                }

                                Spacer()

                                // Weather Icon
                                AsyncImage(url: URL(string: result.iconURL)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                onCitySelected(result.name)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    .padding()
                }
            }
            // Empty State
            else {
                Text("No results found")
                    .foregroundColor(.gray)
                    .padding()
            }

            Spacer()
        }
        .onAppear {
            viewModel.query = query
            viewModel.searchCity() // Trigger search immediately when the view appears
        }
        .navigationTitle("Search City")
    }
}
