//
//  String.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import Foundation

extension String {
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
