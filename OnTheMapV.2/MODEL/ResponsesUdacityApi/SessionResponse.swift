//
//  SessionResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 06/12/2022.
//

import Foundation

struct SessionResponse: Codable {
    
    struct Account: Codable {
        let registered: Bool
        let key: String
    }
    
    struct Session: Codable {
        let id: String
        let expiration: String
    }
    
    let account: Account
    let session: Session
    
}

/*
 9. Udacity API: POSTing a Session.
 Example JSON Response: See Resources
 https://video.udacity-data.com/topher/2016/June/57583f67_post-session/post-session.json
 
 {
     "account":{
         "registered":true,
         "key":"3903878747"
     },
     "session":{
         "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
         "expiration":"2015-05-10T16:48:30.760460Z"
     }
 }
 
 */
