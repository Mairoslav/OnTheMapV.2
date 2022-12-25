//
//  MapTabbedViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 09/12/2022.
//

// import Foundation
import UIKit
import MapKit

class MapTabbedViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: Outlet
    @IBOutlet weak var mapView: MKMapView! // note that view controller is set up to the map view's delegate
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadLocations()
        debugPrint("🔳 MapTabbedView was re/loaded")
    }
    
    // MARK: downloadLocations()
    func downloadLocations() {
        ClientUdacityApi.getStudentInformation { studentLocation, error in
            if error == nil {
                StudentInformationModel.studentLocation = studentLocation // B.11. table is sorted in order of most recent to oldest update because of calling method getStudentInformation line above and assigning studentLocation to StudentInformationModel.studentLocation. In ".studentsLocation" we store array of "GetStudentInformation" struct/s. StudentInformationModel.studentLocation is returned in tableView methods within TableTabbedViewController.swift. Therefore no need to tableView.reloadData() in ViewDidLoad() within TableTabbedViewController.swift. Only makes sense to press refresh button in case to check whether any other students did post new locations since the time that user is logged in. 
                self.createPointAnnotation()
                debugPrint("🔳 100 most recent students posts were downloaded via calling getStudentInformation and createPointAnnotation() methods in func downloadLocations() within MapTabbedViewController.swift")
            } else {
                self .showAlertMessage(title: "Download of Existing Locations Failed", message: ErrorResponse.failedLocationsDownload.localizedDescription) // B.5 the app handles a failure to download student locations
            }
        }
    }
    
    // MARK: createPointAnnotation()
    // B.7. The map view has a pin for each student in the correct location
    func createPointAnnotation() {
        
        // The "locations" array is an array of dictionary objects that are similar to the JSON
        // data that you can download from parse.
        let locations = StudentInformationModel.studentLocation
        
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        for dictionary in locations {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(dictionary.latitude)
            let long = CLLocationDegrees(dictionary.longitude)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = dictionary.firstName
            let last = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations) // B.8. Tapping the pins shows an annotation with the student's name and the link the student posted.
        
    }
    
    // MARK: - MKMapViewDelegate

    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pinBalloon"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView

        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.tintColor = .blue 
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            // let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                openURLLink(urlString: toOpen) // B.9. If the pin annotation is tapped, is the link opened in Safari
                debugPrint("🔳 Annotation/pin infoIcon was tapped ")
            }
        }
    }
}

// MARK: Main.storyboard set up
// option + 2fingerClick on Map View / drag&drop delegate to MapTabbedView
