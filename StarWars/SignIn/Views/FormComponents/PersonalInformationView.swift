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
           
            // MARK: - Name input
            VStack(alignment: .leading, spacing: 4) {
                TextField("Name", text: $name)
                    .focused($isNameFocused)
                    .onChange(of: name) { oldValue, newValue in
                        print("Name changed from: \(oldValue) to: \(newValue)")
                        nameFieldState = .typing
                        print("nameFieldState set to typing")
                    }
                    .onChange(of: isNameFocused) { _, isFocused in
                        print("isNameFocused changed: \(isFocused)")
                        if !isFocused {
                            print("Field lost focus. Validating name...")
                            nameFieldState = viewModel.isNameValid ? .success : .failure
                            print("nameFieldState set to: \(nameFieldState)")
                        }
                    }
                    .onChange(of: viewModel.isNameValid) { oldValue, isValid in
                        print("isNameValid changed from: \(oldValue) to: \(isValid)")
                    }
                UnderlineRectangleView(viewModel: viewModel, field: nameFieldState)
                if nameFieldState == .failure {
                    Text("Name cannot be empty")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding(.vertical, 8)
        
            // MARK: - Lastname input
            VStack(alignment: .leading, spacing: 4) {
                TextField("Last Name", text: $lastName)
                    .focused($isLastNameFocused)
                    .onChange(of: lastName) { oldValue, newValue in
                        lastNameFieldState = .typing
                    }
                    .onChange(of: isLastNameFocused) { _, isFocused in
                        if !isFocused {
                            lastNameFieldState = viewModel.isLastNameValid ? .success : .failure
                        }
                    }
                UnderlineRectangleView(viewModel: viewModel, field: lastNameFieldState)
                if lastNameFieldState == .failure {
                    Text("Last name cannot be empty")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .padding(.vertical, 8)
            
            // MARK: - Age input
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
                    .onChange(of: isAgeFocused) { _, isFocused in
                        if !isFocused {
                            ageFieldState = viewModel.isAgeValid ? .success : .failure
                        }
                    }
                UnderlineRectangleView(viewModel: viewModel, field: ageFieldState)
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
