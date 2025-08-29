//
//  NoDataView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct NoDataView: View {
    
    @State private var showAlert = true
    let error: APIError
    var viewModel: PlanetsViewModel

    var body: some View {
        VStack {
        }
        .alert(
            "Error",
            isPresented: $showAlert,
            presenting: error
        ) { error in
            Button("OK") {
                showAlert = false
            }
            Button("Try Again") {
                viewModel.loadPlanetsOnStart()
                showAlert = false
            }
        } message: { error in
            Text(error.localizedDescription)
                .foregroundColor(Color.red)
        }
    }
}
