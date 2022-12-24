//
//  ErrorResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation
/*
struct ErrorResponse: Codable {
    let status: Int
    let error: String 
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
*/

// ecreate (cutom) ErrorResponse enum that conforms to the Error and Codable protocols
enum ErrorResponse: Error, Codable {
    // Each case of the enum represents a unique error that can be thrown and handled
    case wrongCredentials
    case noConnection
    case unknown(code: Int)
}

// extend the cutom) ErrorResponse to conform to LocalizedError and add a property errorDescription:
extension ErrorResponse: LocalizedError {
    public var errorDescription: String? {
        // For each error type return the appropriate localized description:
        switch self {
            case .wrongCredentials:
                return NSLocalizedString("The credentials were incorrect, please check your email or/and your password.", comment: "Invalid Credentials")
            case .noConnection:
                return NSLocalizedString("The Internet connection is offline, please try again later.", comment: "No Connection")
            case .unknown(_):
                return NSLocalizedString("An unknown error occured", comment: "Unknown Error")
        }
    }
}

// error?.localizedDescription



/*
extension CustomErrorResponse: CustomStringConvertible {
    public var description: String {
        switch self {
            case .wrongCredentials:
                return "The credentials were incorrect, please check your email or/and your password."
            case .connectionOffline:
                return "The Internet connection is offline, please try again later."
            case .unknown(_):
                return "An unknown error occured"
        }
    }
}
*/

