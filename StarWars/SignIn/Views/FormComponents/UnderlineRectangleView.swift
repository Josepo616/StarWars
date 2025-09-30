//
//  UnderlineRectangleView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/29/25.
//

import SwiftUI

struct UnderlineRectangleView: View {

    var viewModel: SignInViewModel
    var field: FieldState

    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(viewModel.colorForState(field))
    }
}
