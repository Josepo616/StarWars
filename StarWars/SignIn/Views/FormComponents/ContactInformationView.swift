//
//  ContactInformationView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/26/25.
//

import SwiftUI

struct ContactInformationView: View {

    @Binding var number: Int
    @Binding var email: String
    @FocusState private var isNumberFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @State private var numberText: String = ""
    @State private var numberFieldState: FieldState = .idle
    @State private var emailFieldState: FieldState = .idle

    var viewModel: SignInViewModel

    var body: some View {
        Section(header: Text("Contact Info").font(.headline)) {
            VStack(alignment: .leading, spacing: 4) {
                TextField("Number", text: $numberText)
                    .focused($isNumberFocused)
                    .keyboardType(.numberPad)
                    .onChange(of: numberText) { _, newValue in
                        if let newNumber = Int(newValue) {
                            number = newNumber
                        } else {
                            number = 0
                        }

                        numberFieldState = .typing
                    }
                    .onChange(of: isNumberFocused) { _, isFocused in
                        if !isFocused {
                            numberFieldState = viewModel.isNumberPhoneValid ? .success : .failure
                        }
                    }

                viewModel.underlineRectangle(numberFieldState)

                if numberFieldState == .failure {
                    Text(
                        "Phone number must have 8 digits, only numbers and not be empty."
                    )
                    .font(.caption)
                    .foregroundColor(.red)
                }
            }

            VStack {
                TextField("Mail", text: $email)
                    .focused($isEmailFocused)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .onChange(of: email) {
                        emailFieldState = .typing
                    }
                    .onChange(of: isEmailFocused) { _, isFocused in
                        if !isFocused {
                            emailFieldState = viewModel.isEmailValid ? .success : .failure
                        }
                    }
                
                viewModel.underlineRectangle(emailFieldState)

                if emailFieldState == .failure {
                    Text("Email is not valid, please try valid email address.")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
