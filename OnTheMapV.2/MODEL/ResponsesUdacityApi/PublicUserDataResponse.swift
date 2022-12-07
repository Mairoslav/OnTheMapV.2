//
//  PublicUserDataResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 07/12/2022.
//

import Foundation

struct PublicUserDataResponse: Codable {
    
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}
