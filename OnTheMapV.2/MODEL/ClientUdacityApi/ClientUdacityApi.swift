//
//  ClientUdacityApi.swift
//  OnTheMapV.2
//
//  Created by mairo on 03/12/2022.
//

import Foundation
import UIKit
import MapKit

// D.1. networking and JSON parsing code placed in its own class
class ClientUdacityApi {
    
    struct Auth {
        static var userId = "" //
        static var objectId = "" // identify student location
        static var firstName = ""
        static var lastName = ""
        static var sessionId = ""
        static var locationAlreadyPosted = false
    }
    
    // MARK: Endpoints
    enum Endpoints {
        
        // MARK: URL components
        static let basePath = "https://onthemap-api.udacity.com/v1"
        static let studentLocationPath = "/StudentLocation"
        static let sessionIdPath = "/session"
        static let publicUserDataPath = "/users"
        
        
        // MARK: Parse Api
        // 5. Parse API: GETting Student Locations - To get multiple student locations at one time, you'll want to use the following API method: https://onthemap-api.udacity.com/v1/StudentLocation Optional parameter: limit, skip, order, uniqueKey(only limit and order are applied). Method type: GET.
        case studentLocation // get multiple student locations at one time
        case limit(Int) // app downloads the (100) most recent locations posted by students.
        // case skip(Int, Int) // limit to paginate through results, not used at all
        case order(limit: Int, sorted: String) // get users location list, see "getStudentInformation"
        // case uniqueKey // Gets only student locations with a given user ID, no need because user IDs are randomized. Note that even though not used as .case for url (~Endpoints.uniqueKey no used), still it is left in struct KeyValuePairs so that can be assigned Auth.userId in clacc func createHttpContent.
        case objectId // identify student location
        
        // 9. Udacity API: POSTing a Session. To authenticate Udacity API requests, you need to *get a session ID. This is accomplished by using Udacity’s session method: https://onthemap-api.udacity.com/v1/session Required Parameters: dictionary let udacity["username": String, "password": String] as per LoginRequest.swift struct
        case sessionId // used for log in/out session
        case publicUserData // random fake user data
        
        
        var stringValue: String {
            switch self {
                case .studentLocation:
                    return Endpoints.basePath + Endpoints.studentLocationPath // To get multiple student locations at one time, use the following API method: see link composed of base + studentLocationPath. Method type: GET. Optional parameter: limit, skip, order, uniqueKey (see code below)
                case .limit(let xyLastPostedLocations):
                    return Endpoints.basePath + Endpoints.studentLocationPath + "?limit=\(xyLastPostedLocations)" // limit - (Number) specifies the maximum number of StudentLocation objects to return in the JSON response. Example: URL + "?limit=100"
                // case .skip(let xyLastPostedLocations, let limitToPaginate):
                    // return Endpoints.base + Endpoints.studentLocationPath + "?limit=\(xyLastPostedLocations)" + "&skip=\(limitToPaginate)" // skip - (Number) use this parameter with limit to paginate through results. Example: URL + "?limit=200&skip=400"
                case .order(let xyLastPostedLocations, let keyName):
                    return Endpoints.basePath + Endpoints.studentLocationPath + "?limit=\(xyLastPostedLocations)" + "&order=\(keyName)" // order - (String) a comma-separate list of key names that specify the sorted order of the results. Prefixing a key name (e.g. updatedAt) with a negative sign reverses the order (default order is ascending). Example: URL + "?order=-updatedAt"
                // case .uniqueKey:
                    // return Endpoints.base + Endpoints.studentLocationPath + "?uniqueKey=\(Auth.userId)" // uniqueKey - (String) a unique key (user ID). Gets only student locations with a given user ID. Filtering by the user ID can be useful if the user has already posted a location (for example, pre-filling the location field). You probably won't need this since the user IDs are randomized. Example: URL + "?uniqueKey=1234"
                case .objectId:
                    return Endpoints.basePath + Endpoints.studentLocationPath + "/\(Auth.objectId)" // objectId: an auto-generated id/key generated by Parse which uniquely identifies a StudentLocation
               
                case .sessionId:
                    return Endpoints.basePath + Endpoints.sessionIdPath // https://onthemap-api.udacity.com/v1/session sessionId: used for log-in/out
                case .publicUserData:
                    return Endpoints.basePath + Endpoints.publicUserDataPath + "/\(Auth.userId)" // retireve/get random/fake user data/IDs (see above comment for "uniqueKey") before they are posted/parsed
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    // MARK: GET
    // 5. Parse API: GETting Student Locations - To get multiple student locations at one time, you'll want to use the following API method: https://onthemap-api.udacity.com/v1/StudentLocation (data)
    // Optional Parameters: limit, skip, order, uniqueKey
    // 11. Udacity API: GETting Public User Data - The whole purpose of using Udacity's API is to retrieve some basic user information before posting data to Parse. This is accomplished by using Udacity’s user method: "https://onthemap-api.udacity.com/v1/users/<user_id>", see ".publicUserData" case. (newData)
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url: URL, getPublicUserData: Bool, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        // D.2. networking code use Swift's built-in "URLSession" class
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if getPublicUserData {
                    let range = 5..<data.count
                    let newData = data.subdata(in: range) // 8. Using the Udacity API - for all responses from the Udacity Api, you need to skip the first 5 characters of the response via subsetting the response data. These characters are used for security purposes.
                    
                    let responseObject = try decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            }catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    
    // MARK: POST
    // 6. Parse API: POSTing a Student Location - To create a new student location, you'll want to use the following API method: https://onthemap-api.udacity.com/v1/StudentLocation (data)
    // 9. Udacity API: POSTing a Session - To authenticate Udacity API requests, you need to get a session ID ("getSessionId: Bool" added). This is accomplished by using Udacity’s session method: https://onthemap-api.udacity.com/v1/session see ".sessionId" case. Required **parameters: udacity(Dictionary) composed of username(String), password(String), see "LoginRequest.swift". (newData)
    @discardableResult class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, getSessionId: Bool, body: RequestType, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body) // ** for .httpBody need three required parameters
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                print("data failed")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if getSessionId {
                    let range = 5..<data.count
                    let newData = data.subdata(in: range)
                    let responseObject = try decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    print("decoding failed during Login")
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    // MARK: PUT
    // 7. Parse API: PUTting a Student Location - To update an existing student location, you'll want to use the following API method: https://onthemap-api.udacity.com/v1/StudentLocation/<objectId>
    // Required Parameters: objectId - (String) the object ID of the StudentLocation to update; specify the object ID right after StudentLocation in URL as seen above
    class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, getSessionId: Bool, body: RequestType, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                print("data failed")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if getSessionId {
                    let range = 5..<data.count
                    let newData = data.subdata(in: range)
                    let responseObject = try decoder.decode(ResponseType.self, from: newData)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } else {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    print("decoding failed during Update")
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: DELETE
    // 10. Udacity API: DELETEing a Session - Once you get a session ID using Udacity's API, you should delete the session ID to "logout". This is accomplished by using Udacity’s session method: https://onthemap-api.udacity.com/v1/session
    class func taskForDELETERequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" {
                xsrfCookie = cookie
            }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    // MARK: login
    // we call this method in @IBAction func loginTapped within LoginViewController.swift
    class func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        // we construct body out of LoginRequest.swift struct, passing in email and password parameters from login method
        let body = LoginRequest(udacity: LoginRequest.RequestToken(username: email, password: password))
        // 9. Udacity API: POSTing a Session. To authenticate Udacity API requests, you need to *get a session ID. This is accomplished by using Udacity’s session method: https://onthemap-api.udacity.com/v1/session Required Parameters: dictionary let udacity["username": String, "password": String] as per LoginRequest.swift struct
        taskForPOSTRequest(url: Endpoints.sessionId.url, getSessionId: true, body: body, responseType: PostSessionResponse.self) { response, error in
            if let response = response {
                // from PostSessionResponse.swift
                Auth.userId =  response.account.key // get userId String
                Auth.sessionId = response.session.id // get sessionId String
                // get random/fake user data/IDs before they are posted/parsed
                getPublicUserData { success, error in
                    if success {
                        completion(true, nil)
                        print("🔳 Random fake user data are retrieved before they are posted via calling getPublicUserData method in class func login")
                    } else {
                        completion(false, error)
                    }
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: getPublicUserData
    // retireve/get random/fake user data/IDs before they are posted/parsed
    class func getPublicUserData(completion: @escaping (Bool, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.publicUserData.url, getPublicUserData: true, responseType: PublicUserDataResponse.self) { response, error in
            if let response = response {
                Auth.firstName = response.firstName
                Auth.lastName = response.lastName
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: getStudentInformation
    // B.1. app downloads the 100 most recent posts (location/urlLink) by students
    class func getStudentInformation(completion: @escaping ([GetStudentInformation.KeyValuePairs], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.order(limit: 100, sorted: "-updatedAt").url, getPublicUserData: false, responseType: GetStudentInformation.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    // MARK: postStudentLocation
    class func postStudentLocation(mapString: String, mediaURL: String, position: CLLocation, completion: @escaping (Bool, Error?) -> Void) {
        let body = createHttpContent(mapString: mapString, mediaURL: mediaURL, position: position)
        taskForPOSTRequest(url: Endpoints.studentLocation.url, getSessionId: false, body: body, responseType: PostStudentLocationResponse.self) { response, error in
            if let response = response {
                Auth.objectId = response.objectId ?? "defaultNil"
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: updateData
    class func updateUserInformation(mapString: String, mediaURL: String, position: CLLocation, completion: @escaping (Bool, Error?) -> Void) {
        let body = createHttpContent(mapString: mapString, mediaURL: mediaURL, position: position)
        taskForPUTRequest(url: Endpoints.objectId.url, getSessionId: false, body: body, responseType: PutUpdateStudentLocationResponse.self) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // MARK: logout
    // B.16. The logout button causes the Student Locations Tabbed View to dismiss, and logs out of the current session.
    class func logout(completion: @escaping (Bool, Error?) -> Void) {
        taskForDELETERequest(url: Endpoints.sessionId.url, responseType: DeleteLogoutResponse.self) { response, error in
            if response != nil {
                Auth.userId = ""
                Auth.objectId = ""
                Auth.firstName = ""
                Auth.lastName = ""
                Auth.sessionId = ""
                Auth.locationAlreadyPosted = false
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    // C.9. app encodes the data in JSON and posts the search string and coordinates to the RESTful service
    // done in class func updateUserInformation and class func postStudentLocation
    class func createHttpContent(mapString: String, mediaURL: String, position: CLLocation) -> GetStudentInformation.KeyValuePairs {
        let body = GetStudentInformation.KeyValuePairs (
            objectId: nil,
            uniqueKey: Auth.userId, // uniqueKey: key used to uniquely identify a StudentLocation; you should populate this value using your Udacity account id ~ userId. Note that even though not used as .case for url (~Endpoints.uniqueKey no used), still it is left in struct KeyValuePairs so that can be assigned Auth.userId in clacc func createHttpContent.
            firstName: Auth.firstName,
            lastName: Auth.lastName,
            mapString: mapString, // provided by user
            mediaURL: mediaURL, // provided by user
            latitude: position.coordinate.latitude, // gps information reported by the system based on provided mapString
            longitude: position.coordinate.longitude,
            createdAt: nil,
            updatedAt: nil
        )
        print("🔳 New location was created/updated (depending on if called in postStudentLocation/updateUserInformation) via func createHttpContent, let body = GetStudentInformation.KeyValuePairs: \(body)")
        return body
    }
    
}


