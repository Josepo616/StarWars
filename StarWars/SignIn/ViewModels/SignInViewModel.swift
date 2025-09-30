//
//  SingInViewModel.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/26/25.
//

import Combine
import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {

    @Published var formModel = SignInFormModel()
    @Published var isNameValid: Bool = false
    @Published var isLastNameValid: Bool = false
    @Published var isAgeValid: Bool = false
    @Published var isNumberPhoneValid: Bool = false
    @Published var isEmailValid: Bool = false
    @Published var isDocumentTypeValid: Bool = false
    @Published var isDocumentNumberValid: Bool = false
    @Published var isFormValid: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupBindings()
    }

    // MARK: - Subscribe to validations

    private func setupBindings() {
        formModel.nameIsValid
            .receive(on: DispatchQueue.main)
            .assign(to: &$isNameValid)

        formModel.lastNameIsValid
            .receive(on: DispatchQueue.main)
            .assign(to: &$isLastNameValid)

        formModel.ageIsValid
            .receive(on: DispatchQueue.main)
            .assign(to: &$isAgeValid)

        formModel.emailIsValid
            .receive(on: DispatchQueue.main)
            .assign(to: &$isEmailValid)

        formModel.numberPhoneIsValid
            .receive(on: DispatchQueue.main)
            .assign(to: &$isNumberPhoneValid)

        formModel.documentTypeIsValid
            .receive(on: DispatchQueue.main)
            .assign(to: &$isDocumentTypeValid)

        formModel.documentNumberIsValid
            .receive(on: DispatchQueue.main)
            .assign(to: &$isDocumentNumberValid)

        formModel.isFormValidPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: &$isFormValid)
    }

    // MARK: - viewHelpers

    func colorForState(_ state: FieldState) -> Color {
        switch state {
        case .idle:
            return .gray
        case .typing:
            return .blue
        case .success:
            return .green
        case .failure:
            return .red
        }
    }
}

// MARK: - enums

enum FieldState {
    case idle, typing, success, failure
}
