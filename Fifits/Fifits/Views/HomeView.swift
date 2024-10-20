//
//  HomeView.swift
//  Fifits
//
//  Created by Lemeng Wang on 10/19/24.
//

//
//  HomeView.swift
//  Fifits
//
//  Created by Lemeng Wang on 10/19/24.
//

import SwiftUI

struct HomeView: View {
    @State private var weatherData: WeatherData? = nil
    @AppStorage("username") var userName = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with greeting and weather view
            HStack {
                Text("Hello \(userName.isEmpty ? "FiFi" : userName)!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
                
                WeatherView(weatherData: $weatherData)
                    .padding(.trailing)
            }
            .padding(.top)
            
            // Conditional rendering based on weather data availability
            if let weatherData = weatherData {
                SuggestedView(weatherData: weatherData)
                    .padding()
            } else {
                Color.gray
                    .cornerRadius(10)
                    .overlay(
                        Text("Waiting for weather data...")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                    )
                    .frame(height: 200)
                    .padding()
            }
            
            Spacer()
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)) // Ensure it matches the system background
    }
}

#Preview {
    HomeView()
}
