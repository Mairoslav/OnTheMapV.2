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

    override func viewDidLoad() {
        super.viewDidLoad()
        // when the activity indicator is stopped it is hidden
        // can be stopped also from storyboard, choose Activity Indicator and in its view choose option Hides When Stopped
        activityIndicator.hidesWhenStopped = true
        
        // tap outside of the pop-up keybord to dismiss it via .endEditing
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        debugPrint("🔳 AddLocationViewController was Loaded")
    }
    
    // MARK: actions
    // C.10. button that the user can tap to cancel (dismiss) the Information Posting View
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil) // returning to previous view ~ tabbedView-Map/Table
        debugPrint("🔳 Returning to previous map/tab-tabbed view via cancel button")
    }
    
    // C.5. When a "Submit/Add Location" button is pressed, the app forward geocodes the address string and stores the resulting latitude and longitude. Foward geocoding can be accomplished using CLGeocoder's geocodeAddressString() or MKLocalSearch's startWithCompletionHandler(). Via func locationToCoordinates
    // segue to next confirmation screen via func addLocationResponse in completion hadnler of func locationToCoordinates
    @IBAction func addLocation(_ sender: UIButton) {
        addingLocation(isLoading: true)
        locationToCoordinates(typedLocationString: self.locationTextField.text ?? "defaultNil", completion: (addLocationResponse(locationCoordinates:error:))) // adding Location String and handling transfer to gps coordinates in completionHandler
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
        addingLocation(isLoading: false)
        if error == nil { // if no error segue to next view controller
            let segueToConfirmLocationVC = storyboard?.instantiateViewController(withIdentifier: "confirmLocation") as! ConfirmLocationViewController
            
            // transfers values on location and url to next view controller
            segueToConfirmLocationVC.locationName = self.locationTextField.text ?? "defaultNil"
            segueToConfirmLocationVC.urlLink = self.urlTextField.text ?? "defaultNil"
            segueToConfirmLocationVC.latitude = locationCoordinates.latitude
            segueToConfirmLocationVC.longitude = locationCoordinates.longitude
            
            present(segueToConfirmLocationVC, animated: true, completion: nil) // and present it
            debugPrint("🔳 New location was added, and is to be confirmed")
        } else {
            // C.7. The app informs the user if the geocoding fails.
            showAlertMessage(title: "Adding Location Failed", message: error?.localizedDescription ?? "defaultNil")
        }
    }
    
    // MARK: addingLocation
    func addingLocation(isLoading: Bool) { // activity indicator not/spinning if not/loading added location
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
        // while added location is being loaded and the activityIndicator spins, fields and button are disabled
        // are enabled when not loading
        locationTextField.isEnabled = !isLoading
        urlTextField.isEnabled = !isLoading
        addLocationButton.isEnabled = !isLoading
    }
    
}


