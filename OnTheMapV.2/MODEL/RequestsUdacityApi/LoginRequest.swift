//
//  LoginRequest.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation

struct LoginRequest: Codable {
    
    struct RequestToken: Codable {
        let username: String
        let password: String
    }
    
    let udacity: RequestToken // udacity - (Dictionary) a dictionary containing a username/password pair used for authentication
    
}
