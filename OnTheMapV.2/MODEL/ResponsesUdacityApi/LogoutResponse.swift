//
//  LogoutResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 07/12/2022.
//

import Foundation

struct LogoutResponse: Decodable {
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
    
    let session: Session
    
}
