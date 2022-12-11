//
//  DeleteLogoutResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 07/12/2022.
//

import Foundation

struct DeleteLogoutResponse: Decodable {
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
    
    let session: Session
    
}

// 10. Udacity API: DELETEing a Session
// Example JSON Response from: https://video.udacity-data.com/topher/2016/June/575840ba_delete-session/delete-session.json

/*
 {
   "session": {
     "id": "1463940997_7b474542a32efb8096ab58ced0b748fe",
     "expiration": "2015-07-22T18:16:37.881210Z"
   }
 }
 */
