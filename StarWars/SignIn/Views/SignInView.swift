//
//  SignInView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/25/25.
//

import SwiftUI

struct SignInView: View {

    @StateObject var signInViewModel: SignInViewModel
    @StateObject var planetViewModel: PlanetsViewModel

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
                            name: $signInViewModel.formModel.name,
                            lastName: $signInViewModel.formModel.lastName,
                            age: $signInViewModel.formModel.age,
                            viewModel: signInViewModel
                        )
                        ContactInformationView(
                            number: $signInViewModel.formModel.numberPhone,
                            email: $signInViewModel.formModel.email,
                            viewModel: signInViewModel
                        )
                        DocumentInformationView(
                            documentType: $signInViewModel.formModel.documentType,
                            documentNumber: $signInViewModel.formModel.documentNumber,
                            viewModel: signInViewModel
                        )

                        Section {
                            NavigationLink(destination: PlanetsView(viewModel: planetViewModel)) {
                                SubmitButton(isEnabled: signInViewModel.isFormValid)
                            }
                            .disabled(false)
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
