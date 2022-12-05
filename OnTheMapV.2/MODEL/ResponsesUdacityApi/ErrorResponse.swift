//
//  ErrorResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation

struct ErrorResponse: Codable {
    let status: Int
    let error: String
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
