//
//  ContentView.swift
//  Fifits
//
//  Created by Lemeng Wang on 10/19/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    var body: some View {
        if !hasLaunchedBefore {
            FirstLaunchView()
            
        } else {
            MainAppView()
        }
    }
}

struct FirstLaunchView: View {
    var body: some View {
        WelcomeView()
    }
}

struct MainAppView: View {
    var body: some View {
        TabView {
            WeatherView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                    
            WardrobeView()
                .tabItem{
                    Label("Wardrobe", systemImage: "hanger")
                }
                    
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            }
            .accentColor(.blue)
        }
}


#Preview {
    ContentView()
}
