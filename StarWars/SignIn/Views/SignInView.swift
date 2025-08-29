//
//  SignInView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/25/25.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()

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
                            name: $viewModel.formModel.name,
                            lastName: $viewModel.formModel.lastName,
                            age: $viewModel.formModel.age,
                            viewModel: viewModel
                        )
                        ContactInformationView(
                            number: $viewModel.formModel.numberPhone,
                            email: $viewModel.formModel.email,
                            viewModel: viewModel
                        )
                        DocumentInformationView(
                            documentType: $viewModel.formModel.documentType,
                            documentNumber: $viewModel.formModel.documentNumber,
                            viewModel: viewModel
                        )
                        
                        Section {
                            NavigationLink(destination: PlanetsView()) {
                                SubmitButton(isEnabled: viewModel.isFormValid)
                            }
                            //.disabled(!viewModel.isFormValid)
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
}
