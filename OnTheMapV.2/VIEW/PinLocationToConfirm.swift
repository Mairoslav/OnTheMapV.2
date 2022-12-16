//
//  PinLocationToConfirm.swift
//  OnTheMapV.2
//
//  Created by mairo on 11/12/2022.
//

import Foundation
import MapKit

class PinLocationToConfirm: NSObject, MKAnnotation { // Cannot declare conformance to 'NSObjectProtocol' in Swift; 'PinLocation' should inherit 'NSObject' instead
    
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(locationName: String?, coordinate: CLLocationCoordinate2D) { 
        self.locationName = locationName
        self.coordinate = coordinate
    }
}
