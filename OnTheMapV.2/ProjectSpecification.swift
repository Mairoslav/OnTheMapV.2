//
//  ProjectSpecification.swift
//  OnTheMapV.2
//
//  Created by mairo on 03/12/2022.
//

import Foundation

// MARK: Project specification for "On the Map" from https://review.udacity.com/#!/rubrics/2114/view

// MARK: Login View

// A.1.
// CRITERIA: Does the app allow the user to login?
// MEETS SPECIFICATIONS: The app has a login view that accepts email and password strings from users, with a “Login” button.
// YES

// A.2.
// CRITERIA: Does the app notify the user if the login fails?
// MEETS SPECIFICATIONS: The app informs the user if the login fails. It differentiates between a failure to connect, and incorrect credentials (i.e., wrong email or password).
// ... NO


// MARK: Student Locations Tabbed View

// B.1.
// CRITERIA: Does the app download locations and links previously posted by students? (to be displayed in the Map and Table tabs)
// MEETS SPECIFICATIONS: The app downloads the 100 most recent locations posted by students.
// WORKING ON ... see "case .limit(let xLastPostedLocations):"

// B.2.
// CRITERIA: Does the app contain a "StudentInformation" struct to store individual locations and links downloaded from the service?
// MEETS SPECIFICATIONS: The app contains a StudentInformation struct with appropriate properties for locations and links.
// YES check file "StudentInformation.swift"

// B.3.
// CRITERIA: Does the "StudentInformation" struct initialize instances from a dictionary?
// MEETS SPECIFICATIONS: The struct has an init() method that accepts a dictionary as an argument, or the struct conforms to the Codable protocol (2nd is valid).
// YES check file "StudentInformationModel.swift"

// B.4.
// CRITERIA: Does the app store the array of StudentInformation structs in a single location, outside of the view controllers?
// MEETS SPECIFICATIONS: The "StudentInformation" structs are stored as an array (or other suitable data structure) inside a separate model class.
// YES check file "StudentInformationModel.swift"

// B.5.
// CRITERIA: Does the app inform the user if the download fails?
// MEETS SPECIFICATION: The app gracefully handles a failure to download student locations.
// ... NOT

// B.6.
// CRITERIA: Does the app correctly display the downloaded data in a tabbed view?
// MEETS SPECIFICATION: The app displays downloaded data in a tabbed view with two tabs: a map and a table.
// ... NOT

// B.7.
// CRITERIA: Does the map view contain a pin for each of the locations that were downloaded?
// MEETS SPECIFICATION: The map view has a pin for each student in the correct location.
// ... NOT

// B.8.
// CRITERIA: When the pins in the map are tapped, is a pin annotation displayed with the relevant information?
// MEETS SPECIFICATION: Tapping the pins shows an annotation with the student's name and the link the student posted.
// ... NOT

// B.9.
// CRITERIA: If the pin annotation is tapped, is the link opened in Safari?
// MEETS SPECIFICATION: Tapping a student’s pin annotation opens the student’s link in Safari or a web view.
// ... NOT

// B.10.
// CRITERIA: Does the table view contain a row for each downloaded location, with the student’s name displayed?
// MEETS SPECIFICATION: The table view has a row for each downloaded record with the student’s name displayed.
// ... NOT

// B.11.
// CRITERIA: Is the table appropriately sorted?
// MEETS SPECIFICATION: The table is sorted in order of most recent to oldest update.
// ... NOT

// B.12.
// CRITERIA: When a row in the table is tapped, does the app open Safari to the student’s link?
// MEETS SPECIFICATION: Tapping a row in the table opens the default device browser to the student's link.
// ... NOT

// B.13.
// CRITERIA: Does the Student Locations Tabbed View have a pin button in the appropriate location?
// MEETS SPECIFICATION: The Student Locations Tabbed View has a pin button in the upper right corner of the navigation bar.
// ... NOT

// B.14.
// CRITERIA: Does the pin button in the navigation bar allow users to post their own information to the server?
// MEETS SPECIFICATION: The button presents the Information Posting View so that users can post their own information to the server.
// ... NOT

// B.15.
// CRITERIA: Does the app have a logout button in the appropriate location?
// MEETS SPECIFICATION: The Student Locations Tabbed View has a logout button in the upper left corner of the navigation bar.
// ... NOT

// B.16.
// CRITERIA: Does the logout button work as intended?
// MEETS SPECIFICATION: The logout button causes the Student Locations Tabbed View to dismiss, and logs out of the current session.
// ... NOT


// MARK: Information Posting View

// C.1.
// CRITERIA: Does the Information Posting View clearly indicate that the user should enter a location?
// MEETS SPECIFICATION: The Information Posting view prompts users to enter a string representing their location.
// ... NOT

// C.2.
// CRITERIA: Does the Information Posting View clearly provide a place for the user to enter a string?
// MEETS SPECIFICATION: The text view or text field where the location string should be typed is clearly present.
// ... NOT

// C.3.
// CRITERIA: Does the app allow users to enter a URL to be included with their location?
// MEETS SPECIFICATION: The app allows users to add a URL to be included with their location.
// ... NOT

// C.4.
// CRITERIA: Does the app provide a button for the user to post the information to the server?
// MEETS SPECIFICATION: The app provides a readily accessible "Submit" button that the user can tap to post the information to the server.
// ... NOT

// C.5.
// CRITERIA: Does the app geocode an address string when the submit button is tapped?
// MEETS SPECIFICATION: When a "Submit" button is pressed, the app forward geocodes the address string and stores the resulting latitude and longitude. Foward geocoding can be accomplished using CLGeocoder's geocodeAddressString() or MKLocalSearch's startWithCompletionHandler().
// ... NOT

// C.6.
// CRITERIA: Does the app indicate activity during the geocoding?
// MEETS SPECIFICATION: An activity indicator is displayed during geocoding, and returns to normal state on completion.
// ... NOT

// C.7.
// CRITERIA: Does the app notify the user if the geocoding fails?
// MEETS SPECIFICATION: The app informs the user if the geocoding fails.
// ... NOT

// C.8.
// CRITERIA: Does the app properly show the geocoded response on a map?
// MEETS SPECIFICATION: The app shows a placemark on a map via the geocoded response. The app zooms the map into an appropriate region.
// ... NOT

// C.9.
// CRITERIA: Does the app post the search string and coordinates to the RESTful service?
// MEETS SPECIFICATION: The app successfully encodes the data in JSON and posts the search string and coordinates to the RESTful service.
// ... NOT

// C.10.
// CRITERIA: Does the app readily allow the user to dismiss the Information Posting View?
// MEETS SPECIFICATION: The app provides a readily accessible button that the user can tap to cancel (dismiss) the Information Posting View.
// ... NOT

// C.11.
// CRITERIA: Does the app notify the user if the post fails?
// MEETS SPECIFICATION: The app inform the user if the post fails.
// ... NOT


// MARK: D) Networking Architecture

// D.1.
// CRITERIA: Is the networking and JSON parsing code placed in its own class?
// MEETS SPECIFICATION: The networking and JSON parsing code is located in a dedicated API client class (and not, for example, inside a view controller). The class uses closures for completion and error handling.
// ... NOT

// D.2.
// CRITERIA: Does the networking code use Swift's built-in "URLSession" class?
// MEETS SPECIFICATION: The networking code uses Swift's built-in URLSession library, not a third-party framework.
// ... NOT

// D.3.
// CRITERIA: Does the JSON parsing code use Swift's built-in JSON parsing capabilities?
// MEETS SPECIFICATION: The JSON parsing code uses Swift's built-in JSONSerialization library or Codable, not a third-party framework.
// ... NOT
