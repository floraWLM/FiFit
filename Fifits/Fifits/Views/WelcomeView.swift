//
//  WelcomeView.swift
//  Fifits
//
//  Created by Allen Zhao on 10/19/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Welcome to FiFits")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                    .frame(maxHeight: .infinity, alignment: .center)
                Spacer()
                NavigationLink(destination: EnterNameView()) {
                    Text("Get Started")
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .padding()
        }
    }
}

struct EnterNameView: View {
    @AppStorage("username") var userName: String = ""
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    @State private var navigateToNextScreen = false
    
    var body: some View {
        VStack {
            Text("Enter Your Name")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .frame(maxHeight: .infinity, alignment: .center)
            
            TextField("Your Name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)
            
            Button(action: {
                navigateToNextScreen = true // Trigger navigation
            }) {
                Text("Next")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(userName.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(userName.isEmpty)
            .padding()
            .frame(maxHeight: .infinity, alignment: .bottom)

            // NavigationLink controlled by navigateToNextScreen state
            NavigationLink(
                destination: EnterBirthDateView(),
                isActive: $navigateToNextScreen
            ) {
                EmptyView()
            }
        }
        .padding()
    }
}


struct EnterBirthDateView: View {
    @State private var bDate = Date()
    @AppStorage("birthdate") private var birthDate: String = ""
    @State private var navigateToMainView = false
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    
    var body: some View {
        VStack {
            Text("Enter Your Birth Date")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .frame(maxHeight: .infinity, alignment: .center)
            
            DatePicker("Date", selection: $bDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding(.bottom, 40)
                .frame(alignment: .center)
                .scaledToFit()

            Button(action: {
                hasLaunchedBefore = true // Update the AppStorage value
                birthDate = bDate.formatted(.iso8601.year().month().day())
                navigateToMainView = true
            }) {
                Text("Finish")
                    .font(.headline)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(bDate > Date() ? Color.gray : Color.blue)
                    .cornerRadius(10)
            }
            .disabled(bDate > Date())
            .padding()
            .frame(maxHeight: .infinity, alignment: .bottom)

            // NavigationLink controlled by navigateToMainView state
            NavigationLink(
                destination: ContentView(),
                isActive: $navigateToMainView
            ) {
                EmptyView()
            }
        }
        .padding()
    }
}


#Preview {
    WelcomeView()
}
