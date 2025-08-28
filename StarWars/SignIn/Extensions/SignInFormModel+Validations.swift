//
//  SignInFormModel+Validations.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import Combine
import Foundation

extension SignInFormModel {

    func isFormValidPublisher() -> AnyPublisher<Bool, Never> {
        nameIsValid
            .combineLatest(lastNameIsValid)
            .combineLatest(ageIsValid)
            .combineLatest(emailIsValid)
            .combineLatest(numberPhoneIsValid)
            .combineLatest(documentTypeIsValid)
            .combineLatest(documentNumberIsValid)
            .map { combined in
                let (
                    (
                        (
                            (
                                ((nameValid, lastNameValid), ageValid),
                                emailValid
                            ), phoneValid
                        ), docTypeValid
                    ), docNumberValid
                ) = combined
                return nameValid && lastNameValid && ageValid && emailValid
                    && phoneValid && docTypeValid && docNumberValid
            }
            .eraseToAnyPublisher()
    }

    var nameIsValid: AnyPublisher<Bool, Never> {
        $name
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    var lastNameIsValid: AnyPublisher<Bool, Never> {
        $lastName
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    var ageIsValid: AnyPublisher<Bool, Never> {
        $age
            .map { $0 > 18 }
            .eraseToAnyPublisher()
    }

    var emailIsValid: AnyPublisher<Bool, Never> {
        $email
            .map { email in
                guard !email.isEmpty else { return false }

                let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
                return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }

    var numberPhoneIsValid: AnyPublisher<Bool, Never> {
        $numberPhone
            .map { String($0).count == 8 }
            .eraseToAnyPublisher()
    }

    var documentTypeIsValid: AnyPublisher<Bool, Never> {
        $documentType
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    var documentNumberIsValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($documentType, $documentNumber)
            .map { type, number in
                let regex: String
                
                switch type.lowercased() {
                case "id":
                    regex = "^[0-9]{8}$"
                case "passport":
                    regex = "^[A-Za-z]{1}[0-9]{8}$"
                default:
                    return false
                }

                return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: number)
            }
            .eraseToAnyPublisher()
    }
}

