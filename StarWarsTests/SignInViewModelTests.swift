//
//  SignInViewModelTests.swift
//  StarWars
//
//  Created by JoseAlvarez on 9/30/25.
//

import Combine
import XCTest

@testable import StarWars

final class SignInViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func testSignInViewModelValidFormBecomesValid() {
        /// Given
        let vm = SignInViewModel()
        let exp = expectation(description: "form becomes valid")
        /// When
        vm.$isFormValid
            .dropFirst()
            .sink { isValid in
                if isValid {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        vm.formModel.name = "John"
        vm.formModel.lastName = "Doe"
        vm.formModel.age = 30
        vm.formModel.numberPhone = "12345678"
        vm.formModel.email = "a@b.com"
        vm.formModel.documentType = "ID"
        vm.formModel.documentNumber = "12345678"
        wait(for: [exp], timeout: 1.0)
        /// Then
        XCTAssertTrue(vm.isFormValid)
    }

    func testSignInViewModelEmptyNameBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        vm.formModel.name = ""
        /// When
        HelperFunctions.fillValidFormExcept(vm, except: \SignInFormModel.name)
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }

    func testSignInViewModelEmptyLastNameBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        vm.formModel.lastName = ""
        /// When
        HelperFunctions.fillValidFormExcept(
            vm,
            except: \SignInFormModel.lastName
        )
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }

    func testSignInViewModelAgeZeroBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        vm.formModel.age = 0
        /// When
        HelperFunctions.fillValidFormExcept(vm, except: \SignInFormModel.age)
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }

    func testSignInViewModelEmptyPhoneBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        vm.formModel.numberPhone = ""
        /// When
        HelperFunctions.fillValidFormExcept(
            vm,
            except: \SignInFormModel.numberPhone
        )
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }

    func testSignInViewModelInvalidEmailBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        vm.formModel.email = "invalidemail"
        /// When
        HelperFunctions.fillValidFormExcept(vm, except: \SignInFormModel.email)
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }

    func testSignInViewModelEmptyDocumentTypeBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        vm.formModel.documentType = ""
        /// When
        HelperFunctions.fillValidFormExcept(
            vm,
            except: \SignInFormModel.documentType
        )
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }

    func testSignInViewModelEmptyDocumentNumberBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        vm.formModel.documentNumber = ""
        /// When
        HelperFunctions.fillValidFormExcept(
            vm,
            except: \SignInFormModel.documentNumber
        )
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }

    func testSignInViewModelAllFieldsEmptyBecomesInvalid() {
        /// Given
        let vm = SignInViewModel()
        /// When
        /// Nothing is set
        /// Then
        XCTAssertFalse(vm.isFormValid)
    }
}
