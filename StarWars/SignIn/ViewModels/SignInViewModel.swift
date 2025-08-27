//
//  SingInViewModel.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/26/25.
//

import Foundation
import SwiftUI

struct SignInViewModel {

    // MARK: - Validations
    func validateName(_ name: String) -> Bool {
        return !name.isEmpty
    }

    func validateLastName(_ lastName: String) -> Bool {
        return !lastName.isEmpty
    }

    func validateAge(_ age: Int) -> Bool {
        return age > 18
    }

    func validateEmail(_ email: String) -> Bool {
        guard !email.isEmpty else { return false }

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailPredicate.evaluate(with: email)

    }

    func validatePhoneNumber(_ numberPhone: Int) -> Bool {
        return String(numberPhone).count == 8
    }

    func validateDocumentType(_ documentType: String) -> Bool {
        return !documentType.isEmpty
    }

    func validateDocumentNumber(
        _ documentType: String,
        _ documentNumber: String
    ) -> Bool {
        switch documentType.lowercased() {
        case "id":
            let idRegex = "^[0-9]{8}$"
            return NSPredicate(format: "SELF MATCHES %@", idRegex).evaluate(
                with: documentNumber
            )

        case "passport":
            let passportRegex = "^[A-Za-z]{1}[0-9]{8}$"
            return NSPredicate(format: "SELF MATCHES %@", passportRegex)
                .evaluate(with: documentNumber)

        default:
            return false
        }
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

    func underlineRectangle(_ Field: FieldState) -> some View {

        Rectangle()
            .frame(height: 1)
            .foregroundColor(colorForState(Field))
    }
}

// MARK: - enums

enum FieldState {
    case idle, typing, success, failure
}
