//
//  SettingView.swift
//  Fifits
//
//  Created by Allen Zhao on 10/19/24.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var selectedLanguage = "English" // Placeholder for language selection
    @State private var showSignOutAlert = false
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            List {
                // Language Option (Placeholder for language selection)
                Button(action: {
                    // Placeholder action for language selection
                    print("Language option tapped")
                }) {
                    HStack {
                        Text("Language")
                        Spacer()
                        Text(selectedLanguage) // Display selected language
                            .foregroundColor(.gray)
                    }
                }
                
                // Dark Mode Toggle
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                .onChange(of: isDarkMode) { newValue in
                    // Action to switch between dark/light modes
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    windowScene?.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                }
                
                // Sign Out Option
                Button(action: {
                    showSignOutAlert = true
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $showSignOutAlert) {
                    Alert(
                        title: Text("Sign Out"),
                        message: Text("Are you sure you want to sign out?"),
                        primaryButton: .destructive(Text("Sign Out"), action: {
                            // Placeholder for sign-out action
                            print("User signed out")
                        }),
                        secondaryButton: .cancel()
                    )
                }
            }
            Spacer()
            Text("About Us")
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingView()
}

