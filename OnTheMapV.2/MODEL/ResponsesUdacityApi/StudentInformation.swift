//
//  Student.swift
//  OnTheMapV.2
//
//  Created by mairo on 03/12/2022.
//

import Foundation

// MARK: B.2. "StudentInformation" struct to store individual locations and links downloaded from the service

struct StudentInformation: Codable, Equatable { // In Parse, each StudentLocation is represented as a collection of key/value pairs (Parse Types are String, String?, Double):
    
    let objectId: String? /* // MARK: 1. id
    Description: an auto-generated id/key generated by Parse which uniquely identifies a StudentLocation
    Example Value: 8ZExGR5uX8 */
    
    let uniqueKey: String? /* // MARK: 2. extra (optional) id
    Description: an extra (optional) key used to uniquely identify a StudentLocation; you should populate this value using your Udacity account id
    Example Value: 1234 */
    
    let firstName: String /* // MARK: 3. name
    Description: the first name of the student which matches their Udacity profile first name OR an anonymized name hardcoded in your app (see above)
    Example Value: Juliette */
    
    let lastName: String /* // MARK: 4. surname
    Description: the last name of the student which matches their Udacity profile last name OR an anonymized name hardcoded in your app (see above)
    Example Value: Voel */
    
    let mapString: String /* // MARK: 5. address
    Description: the location string used for geocoding the student location
    Example Value: Mountain View, CA */
    
    let mediaURL: String /* // MARK: 6. link
    Description: the URL provided by the student
    Example Value: https://udacity.com */
    
    let latitude: Double /* // MARK: 7. y
    Description: the latitude of the student location (ranges from -90 to 90)
    Example Value: 37.386052 */
    
    let longitude: Double /* // MARK: 8. x
    Description: the longitude of the student location (ranges from -180 to 180)
    Example Value: -122.083851 */
    
    // YOU DO NOT HAVE TO WORRY ABOUT PARSING DATE OR ACL TYPES:
    /*
    let createdAt: String
    let updatedAt: String
    let ACL: acl_type_t
     */
    
}
