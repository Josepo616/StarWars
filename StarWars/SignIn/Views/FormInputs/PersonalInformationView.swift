//
//  PersonalInformationView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/26/25.
//

import SwiftUI

struct PersonalInformationView: View {
    
    @Binding var name: String
    @Binding var lastName: String
    @Binding var age: Int
    @FocusState private var isNameFocused: Bool
    @FocusState private var isLastNameFocused: Bool
    @FocusState private var isAgeFocused: Bool
    @State var ageText = ""
    @State private var nameFieldState: FieldState = .idle
    @State private var lastNameFieldState: FieldState = .idle
    @State private var ageFieldState: FieldState = .idle
    
    var viewModel: SignInViewModel


    var body: some View {
        Section(header: Text("Personal Information").font(.headline)) {
            
            VStack(alignment: .leading, spacing: 4) {
                TextField("Name", text: $name)
                    .focused($isNameFocused)
                    .onChange(of: name) { oldValue, newValue in
                        nameFieldState = .typing
                    }
                    .onChange(of: isNameFocused) { oldValue, isFocused in
                        if !isFocused {
                            if name.isEmpty {
                                nameFieldState = .failure
                            } else if viewModel.validateName(name) {
                                nameFieldState = .success
                            } else {
                                nameFieldState = .failure
                            }
                        }
                        
                    }

                viewModel.underlineRectangle(nameFieldState)
                
                if nameFieldState == .failure {
                    Text("Name cannot be empty")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding(.vertical, 8)

            VStack(alignment: .leading, spacing: 4) {
                TextField("Last Name", text: $lastName)
                    .focused($isLastNameFocused)
                    .onChange(of: lastName) { oldValue, newValue in
                        lastNameFieldState = .typing
                    }
                    .onChange(of: isLastNameFocused) { oldValue, isFocused in
                        if !isFocused {
                            if lastName.isEmpty {
                                lastNameFieldState = .failure
                            } else if viewModel.validateName(lastName) {
                                lastNameFieldState = .success
                            } else {
                                lastNameFieldState = .failure
                            }
                        }
                    }
                
                viewModel.underlineRectangle(lastNameFieldState)

                if lastNameFieldState == .failure {
                    Text("Last name cannot be empty")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                TextField("Age", text: $ageText)
                    .focused($isAgeFocused)
                    .keyboardType(.numberPad)
                    .onChange(of: ageText) { oldValue, newValue in
                        if let newNumber = Int(newValue) {
                            age = newNumber
                        } else {
                            age = 0
                        }
                        ageFieldState = .typing
                    }
                    .onChange(of: isAgeFocused) { oldValue, isFocused in
                        if !isFocused {
                            if ageText.isEmpty {
                                ageFieldState = .failure
                            } else if viewModel.validateAge(age) {
                                ageFieldState = .success
                            } else {
                                ageFieldState = .failure
                            }
                        }
                    }
                
                viewModel.underlineRectangle(ageFieldState)

                if ageFieldState == .failure {
                    Text("Age must be older than 18 and cant be empty")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding(.vertical, 8)
        }
    }
}
