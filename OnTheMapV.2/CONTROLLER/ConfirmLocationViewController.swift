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
    var addedLocationCoordiantes: CLLocation!
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
        if ClientUdacityApi.Auth.locationAlreadyPosted == false {
            ClientUdacityApi.postStudentLocation(mapString: locationName, mediaURL: urlLink, position: addedLocationCoordiantes, completion: confirmLocationResponse(success:eror:))
            debugPrint("🔳 New location \(locationName ?? "nil") of user \(ClientUdacityApi.Auth.firstName) \(ClientUdacityApi.Auth.lastName) was confirmed and Posted, there had been no previous location posted in this session")
        } else {
            ClientUdacityApi.updateUserInformation(mapString: locationName, mediaURL: urlLink, position: addedLocationCoordiantes, completion: confirmLocationResponse(success:eror:))
            debugPrint("🔳 New location \(locationName ?? "nil") of user \(ClientUdacityApi.Auth.firstName) \(ClientUdacityApi.Auth.lastName) was confirmed and Updated, previous location posted in in this session has been overwritten")
        }
    }
    
    @IBAction func backToAddLocation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil) // transition to previous view controller ~ AddLocationViewController
    }
    
    // MARK: zoomAndDropPin
    // C.8. The app shows a placemark on a map via the geocoded response. The app zooms the map into an appropriate region.
    func zoomAndDropPin() {
        addedLocationCoordiantes = CLLocation(latitude: latitude, longitude: longitude)
        zoomInToAddedLocation(addedLocationCoordiantes)
        let pinLocationToConfirm = PinLocationToConfirm(locationName: locationName, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        mapViewToConfirmLocation.addAnnotation(pinLocationToConfirm)
    }
    
    // MARK: confirmLocationResponse
    func confirmLocationResponse(success: Bool, eror: Error?) {
        if success {
            // if success transition to "MapTabbedViewController"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MapTabbedViewController = storyboard.instantiateViewController(withIdentifier: "MapTabbedViewController")
            present(MapTabbedViewController, animated: true)
            debugPrint("🔳 After new location is confirmed, MapTabbedViewController is instatiated thanks to calling func confirmLocationResponse within @IBAction func confirmLocationTapped")
        } else {
            showAlertMessage(title: "Location Confirmation Failed", message: ErrorResponse.failedLocationConfirmation.localizedDescription)
        }
    }
    
    // MARK: zoomInToAddedLocation
    func zoomInToAddedLocation(_ location: CLLocation, zoomLevelInMeters: CLLocationDistance = 5000) {
        
        let addedLocation = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: zoomLevelInMeters, longitudinalMeters: zoomLevelInMeters)
        mapViewToConfirmLocation.setRegion(addedLocation, animated: true)
        
    }
    
}
