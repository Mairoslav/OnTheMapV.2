//
//  AddLocationViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 11/12/2022.
//

import Foundation
import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    // MARK: outlets
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    // no viewDidLoad()
    
    // MARK: actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil) // returns to previous view ~ tabbedView
    }
    
    @IBAction func addLocation(_ sender: UIButton) {
        addLocationLoading(true)
        locationToCoordinates(typedLocationString: self.locationTextField.text ?? "", completion: (addLocationResponse(locationCoordinates:error:))) // adding Location String and handling transfer to gps coordinates in completionHandler
    }
    
    // MARK: locationToCoordinates
    func locationToCoordinates(typedLocationString: String, completion: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
        let geoConverter = CLGeocoder() // converts location name* to gps coordinates
        geoConverter.geocodeAddressString(typedLocationString) { placemark, error in
            if error == nil {
                if let locationName = placemark?[0] { // e.g. *"London" as first String within whole address
                    let location = locationName.location!
                    completion(location.coordinate, nil)
                    return
                }
            }
            completion(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    // MARK: addLocationResponse
    func addLocationResponse(locationCoordinates: CLLocationCoordinate2D, error: Error?) {
        addLocationLoading(false)
        if error == nil { // if no error segue to next view controller
            let segueToConfirmLocationVC = storyboard?.instantiateViewController(withIdentifier: "confirmLocation") as! ConfirmLocationViewController
            
            // transfers values on location and url to next view controller
            segueToConfirmLocationVC.locationName = self.locationTextField.text ?? ""
            segueToConfirmLocationVC.urlLink = self.urlTextField.text ?? ""
            segueToConfirmLocationVC.latitude = locationCoordinates.latitude
            segueToConfirmLocationVC.longitude = locationCoordinates.longitude
            
            present(segueToConfirmLocationVC, animated: true, completion: nil) // and present it
        } else {
            showAlertMessage(title: "Adding Location Failed", message: "Location has not been Found, try again.")
        }
    }
    
    // MARK: addLocationLoading
    func addLocationLoading(_ loading: Bool) { // activity indicator not/spinning if not/loading added location
        if loading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        // while added location is being loaded and the activityIndicator spins, fields and button are disabled
        // are enabled when not loading
        self.locationTextField.isEnabled = !loading
        self.urlTextField.isEnabled = !loading
        self.addLocationButton.isEnabled = !loading
    }
    
}


