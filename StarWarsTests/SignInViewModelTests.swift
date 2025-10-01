//
//  SignInViewModelTests.swift
//  StarWars
//
//  Created by JoseAlvarez on 9/30/25.
//

import XCTest
import Combine
@testable import StarWars

final class SignInViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func test_signInViewModel_validForm_becomesValid() {
        let vm = SignInViewModel()

        let exp = expectation(description: "form becomes valid")
        vm.$isFormValid.dropFirst().sink { isValid in
            if isValid {
                exp.fulfill()
            }
        }.store(in: &cancellables)

        vm.formModel.name = "John"
        vm.formModel.lastName = "Doe"
        vm.formModel.age = 30
        vm.formModel.numberPhone = "12345678"
        vm.formModel.email = "a@b.com"
        vm.formModel.documentType = "ID"
        vm.formModel.documentNumber = "12345678"

        wait(for: [exp], timeout: 1.0)
        XCTAssertTrue(vm.isFormValid)
    }
}
