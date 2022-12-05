//
//  ClientUdacityApi.swift
//  OnTheMapV.2
//
//  Created by mairo on 03/12/2022.
//

import Foundation
import UIKit

class ClientUdacityApi {
    
    struct Auth {
        static var userId = ""
        static var objectId = ""
        static var firstName = ""
        static var lastName = ""
    }
    
    enum Endpoints {
        // URL components
        static let base = "https://onthemap-api.udacity.com/v1"
        static let studentLocationPath = "/StudentLocation"
        
        // ... other URL components ...
        
        // MARK: Parse API: GET-ting Student Locations
        // To get multiple student locations at one time, you'll want to use the following API method: https://onthemap-api.udacity.com/v1/StudentLocation Optional parameter: limit, skip, order, uniqueKey. Method type: GET.
        case studentLocation // get multiple student locations at one time
        case limit(Int) // app downloads the (100) most recent locations posted by students.
        case skip(Int, Int) // limit to paginate through results
        case order(limit: Int, sorted: String)
        case uniqueKey // user can post only one location
        
        // MARK: Parse API: POST-ing a Student Location
        case objectId // identify student location
        
        
        var stringValue: String {
            switch self {
                case .studentLocation:
                    return Endpoints.base + Endpoints.studentLocationPath // To get multiple student locations at one time, use the following API method: see link composed of base + studentLocationPath. Method type: GET. Optional parameter: limit, skip, order, uniqueKey (see code below)
                case .limit(let xyLastPostedLocations):
                    return Endpoints.base + Endpoints.studentLocationPath + "?limit=\(xyLastPostedLocations)" // limit - (Number) specifies the maximum number of StudentLocation objects to return in the JSON response. Example: URL + "?limit=100"
                case .skip(let xyLastPostedLocations, let limitToPaginate):
                    return Endpoints.base + Endpoints.studentLocationPath + "?limit=\(xyLastPostedLocations)" + "&skip=\(limitToPaginate)" // skip - (Number) use this parameter with limit to paginate through results. Example: URL + "?limit=200&skip=400"
                case .order(let xyLastPostedLocations, let keyName):
                    return Endpoints.base + Endpoints.studentLocationPath + "?limit=\(xyLastPostedLocations)" + "&order=\(keyName)" // order - (String) a comma-separate list of key names that specify the sorted order of the results. Prefixing a key name (e.g. updatedAt) with a negative sign reverses the order (default order is ascending). Example: URL + "?order=-updatedAt"
                case .uniqueKey:
                    return Endpoints.base + Endpoints.studentLocationPath + "?uniqueKey=\(Auth.userId)" // uniqueKey - (String) a unique key (user ID). Gets only student locations with a given user ID. Filtering by the user ID can be useful if the user has already posted a location (for example, pre-filling the location field). You probably won't need this since the user IDs are randomized. Example: URL + "?uniqueKey=1234"
                
                case .objectId:
                    return Endpoints.base + Endpoints.studentLocationPath + "/\(Auth.objectId)"
                    
                // ...CONTINUE... check what need to be done for login/logout/authentication ... together with other keywords... 
            }
            
        }
        
    }
    
}
