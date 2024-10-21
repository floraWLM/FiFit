//
//  ProfileView.swift
//  Fifits
//
//  Created by Allen Zhao on 10/19/24.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("username") var userName = ""
    @AppStorage("birthdate") var bDate = ""
    @State private var avatar: Image? = Image("avatar")
    @State private var isEditing: Bool = false
    @State private var newUserName: String = ""
    @State private var showDatePicker = false
    @State private var birthDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    avatar?
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    
                    if isEditing {
                        TextField("Enter new name", text: $newUserName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 10)
                    } else {
                        Text(userName)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.leading, 10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if isEditing {
                            userName = newUserName.isEmpty ? userName : newUserName
                            newUserName = ""
                        }
                        isEditing.toggle()
                    }) {
                        Image(systemName: isEditing ? "checkmark" : "square.and.pencil")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 20)
                }
                .padding()
                
                // List with Update Birthdate
                List {
                    Text("Update Birthdate").onTapGesture {
                        showDatePicker = true
                    }
                }

                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                    }
                }
            }
            // Pop-up using .sheet
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    Text("Select Your Birth Date")
                        .font(.headline)
                        .padding()
                    Text("Current Birthdate: " + bDate)
                    DatePicker("Select Date", selection: $birthDate, displayedComponents: .date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .padding()

                    HStack {
                        // Cancel button
                        Button(action: {
                            showDatePicker = false
                        }) {
                            Text("Cancel")
                                .font(.headline)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        // Save button
                        Button(action: {
                            bDate = birthDate.formatted(.iso8601.year().month().day())
                            showDatePicker = false
                        }) {
                            Text("Save")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ProfileView()
}
