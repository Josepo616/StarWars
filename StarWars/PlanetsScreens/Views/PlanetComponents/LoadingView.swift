//
//  LoadingView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ProgressView("Loading planets...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
}
