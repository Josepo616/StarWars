//
//  StarWarsApp.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/25/25.
//

import SwiftUI

@main
struct StarWarsApp: App {
    @State var name: String = ""
    @State var lastName: String = ""
    @State var age: Int = 0
    @State var number: Int = 0
    @State var email: String = ""
    @State var documentType: String = ""
    @State var documentNumber: String = ""

    var body: some Scene {
        WindowGroup {
            SignInView(name: $name, lastName: $lastName, age: $age, number: $number, email: $email, documentType: $documentType, documentNumber: $documentNumber)
        }
    }
}
