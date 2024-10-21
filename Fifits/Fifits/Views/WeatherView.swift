//
//  WeatherView.swift
//  Fifits
//
//  Created by Lemeng Wang on 10/19/24.
//

import SwiftUI
import Foundation
import CoreLocation

struct WeatherView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData?
    
    var body: some View {
        VStack{
            if let weatherData = weatherData {
                Text("\(Int(weatherData.temperature))°C").font(.custom("", size: 70))
                    .padding()
                VStack{
                    Text("\(weatherData.locationName)")
                        .font(.title2).bold()
                    Text("\(weatherData.condition)")
                        .font(.body).bold()
                        .foregroundColor(.gray)
                }
            }else{
                ProgressView()
            }
        }
        .frame(width:300, height:300)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .onAppear{
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$location) { location in
            guard let location = location else {
                    print("Location is nil")
                    return
            }
            print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            fetchWeatherData(for: location)
        }
    }
        
    private func fetchWeatherData(for location: CLLocation){
            let apiKey = "b2e5d7442278a30909dcc92e3ae3f7c9"
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&appid=\(apiKey)"
            print(urlString)
            
            guard let url = URL(string: urlString)else {return}
            
            URLSession.shared.dataTask(with: url){data, _, error in
                if let error = error {
                        print("Network error: \(error.localizedDescription)")
                        return
                }
                guard let data = data else {return}
                
                if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON Response: \(jsonString)")
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from:data)
                    
                    DispatchQueue.main.async{
                        weatherData = WeatherData(locationName: weatherResponse.name, temperature: weatherResponse.main.temp, condition: weatherResponse.weather.first?.description ?? "")
                    }
                } catch{
                    print(error.localizedDescription)
                }
            }.resume()
        }
}
    
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
