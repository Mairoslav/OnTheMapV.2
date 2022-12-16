//
//  PostStudentLocationResponse.swift
//  OnTheMapV.2
//
//  Created by mairo on 04/12/2022.
//

import Foundation

struct PostStudentLocationResponse: Codable {
    
    let createdAt: String?
    let objectId: String?
    
}

// 6. Parse API: POSTing a Student Location
// Example JSON Response from: https://video.udacity-data.com/topher/2016/June/57583e35_post-student-location/post-student-location.json

/*
 {
     "createdAt":"2015-03-11T02:48:18.321Z",
     "objectId":"CDHfAy8sdp"
 }
 */


