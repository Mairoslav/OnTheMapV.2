//
//  ConfirmLocationViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 11/12/2022.
//

import Foundation
import UIKit
import MapKit

class ConfirmLocationViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: properties
    var locationName: String!
    var urlLink: String!
    var addedGpsLocation: CLLocation!
    var latitude: Double!
    var longitude: Double!
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomAndDropPin()
    }
    
    // MARK: outletmapViewToConfirmLocation
    
    @IBOutlet weak var mapViewToConfirmLocation: MKMapView!
    
    // MARK: actions
    @IBAction func confirmLocationTapped(_ sender: UIButton) {
        if ClientUdacityApi.Auth.pinAlreadyPosted != true {
            ClientUdacityApi.postStudentLocation(mapString: locationName, mediaURL: urlLink, position: addedGpsLocation, completion: confirmLocationResponse(success:eror:))
        }
    }
    
    @IBAction func backToAddLocation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil) // transition to previous view controller ~ AddLocationViewController
    }
    
    // MARK: zoomAndDropPin
    func zoomAndDropPin() {
        addedGpsLocation = CLLocation(latitude: latitude, longitude: longitude) // drop pin to xy gps location
        zoomIn(addedGpsLocation, 50_000, 50_000) // 1_000 by default set in zoomIn method
        let pinLocationToConfirm = PinLocationToConfirm(locationName: locationName, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapViewToConfirmLocation.addAnnotation(pinLocationToConfirm)
    }
    
    // MARK: confirmLocationResponse
    func confirmLocationResponse(success: Bool, eror: Error?) {
        if success { // if success transition to "MapViewController"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MapTabbedViewController = storyboard.instantiateViewController(withIdentifier: "MapTabbedViewController")
            present(MapTabbedViewController, animated: true)
        } else {
            showAlertMessage(title: "Adding Location Failed", message: eror?.localizedDescription ??  "Unable to Post User Information")
        }
    }
    
    // MARK: zoomIn
    func zoomIn(_ location: CLLocation, _ spanInMetersLatidute: CLLocationDistance = 1_000, _ spanInMetersLongitute: CLLocationDistance = 1_000) {
        let zoomedLocation = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: spanInMetersLatidute, longitudinalMeters: spanInMetersLongitute)
        self.mapViewToConfirmLocation.setRegion(zoomedLocation, animated: true)
    }
}
