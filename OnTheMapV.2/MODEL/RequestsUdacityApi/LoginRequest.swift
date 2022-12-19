//
//  LoginRequest.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation

// 9. Udacity API: POSTing a Session. To authenticate Udacity API requests, you need to get a session ID. This is accomplished by using Udacity’s session method: https://onthemap-api.udacity.com/v1/session method: POST, Required Parameters: 1, 2, 3 check below
    
struct LoginRequest: Codable {
    
    struct RequestToken: Codable {
        let username: String // 2. username - (String) the username (email) for a Udacity student
        let password: String // 3. password - (String) the password for a Udacity student
    }
    
    let udacity: RequestToken // 1. udacity - (Dictionary) a dictionary containing a username/password pair used for authentication
    
}
