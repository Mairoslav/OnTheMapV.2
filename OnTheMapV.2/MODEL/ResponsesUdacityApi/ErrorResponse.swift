//
//  ErrorResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation

enum ErrorResponse: Codable, Error {
    case slowConnection
    case noConnection
    case wrongCredentials
    case failedLocationsDownload
    case notRecognizedLocation
    case failedLocationConfirmation
    case failedDataRefresh
    case failedLogOut
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .slowConnection:
                return NSLocalizedString("The Internet connection speed is not sufficient to load the app.", comment: "")
            case .noConnection:
                return NSLocalizedString("The Internet connection is offline, please try again later.", comment: "")
            case .wrongCredentials:
                return NSLocalizedString("The credentials were incorrect, please check your email or/and your password.", comment: "")
            case .failedLocationsDownload:
                return NSLocalizedString("Download of existing Locations Failed, please report this issue to app provider.", comment: "")
            case .notRecognizedLocation:
                return NSLocalizedString("Location you have specified has not been recognized, please try typing in your Location again.", comment: "")
            case .failedLocationConfirmation:
                return NSLocalizedString("Something went wrong with your Location Confirmation, please report this issue to app provider.", comment: "")
            case .failedDataRefresh:
                return NSLocalizedString("Reloading of existing Locations has Failed, please report this issue to app provider.", comment: "")
            case .failedLogOut:
                return NSLocalizedString("Loggin out has failed, please report this issue to app provider.", comment: "")
        }
    }
}


