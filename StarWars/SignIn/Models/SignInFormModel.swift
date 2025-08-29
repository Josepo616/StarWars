//
//  SignInFormModel.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import Foundation
import Combine

class SignInFormModel: ObservableObject {
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var age: Int = 0
    @Published var numberPhone: String = ""
    @Published var email: String = ""
    @Published var documentType: String = ""
    @Published var documentNumber: String = ""
}
