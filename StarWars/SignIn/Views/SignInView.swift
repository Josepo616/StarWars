//
//  SignInView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/25/25.
//

import SwiftUI

struct SignInView: View {

    @Binding var name: String
    @Binding var lastName: String
    @Binding var age: Int
    @Binding var number: Int
    @Binding var email: String
    @Binding var documentType: String
    @Binding var documentNumber: String

    var isFormValid: Bool {
        viewModel.validateName(name) && viewModel.validateLastName(lastName)
            && viewModel.validateAge(age) && viewModel.validateEmail(email)
            && viewModel.validatePhoneNumber(number)
            && viewModel.validateDocumentType(documentType)
            && viewModel.validateDocumentNumber(documentType, documentNumber)
    }

    var viewModel = SignInViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 20)
                        .padding(.bottom, 10)

                    Form {
                        PersonalInformationView(
                            name: $name,
                            lastName: $lastName,
                            age: $age,
                            viewModel: viewModel
                        )
                        ContactInformationView(
                            number: $number,
                            email: $email,
                            viewModel: viewModel
                        )
                        DocumentInformationView(
                            documentType: $documentType,
                            documentNumber: $documentNumber,
                            viewModel: viewModel
                        )

                        Section {
                            NavigationLink(destination: PlanetsView()) {
                                Button(action: {
                                }) {
                                    Text("Submit")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            //.disabled(!isFormValid)  // Deshabilitar el botón si el formulario no es válido
                            //.navigationTitle("Planets")
                        }
                        .frame(maxWidth: 400, maxHeight: 700)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .scaleEffect(0.9)
                    }
                }
            }
        }
    }
}
