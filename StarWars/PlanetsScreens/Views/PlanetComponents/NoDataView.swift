//
//  NoDataView.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import SwiftUI

struct NoDataView: View {
    let error: APIError
    
    var body: some View {
        Text(error.localizedDescription)
            .font(.headline)
            .foregroundColor(.red)
            .padding()
    }
}  
