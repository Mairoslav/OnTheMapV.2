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
// ... NO

// A.2.
// CRITERIA: Does the app notify the user if the login fails?
// MEETS SPECIFICATIONS: The app informs the user if the login fails. It differentiates between a failure to connect, and incorrect credentials (i.e., wrong email or password).
// ... NO


// MARK: Student Locations Tabbed View

// B.1.
// CRITERIA: Does the app download locations and links previously posted by students? (to be displayed in the Map and Table tabs)
// MEETS SPECIFICATIONS: The app downloads the 100 most recent locations posted by students.
// ... NO

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

// B.5
// CRITERIA:
// MEETS SPECIFICATION:
// ... NOT

// B.6
// CRITERIA:
// MEETS SPECIFICATION:
// ... NOT

// B.7
// CRITERIA:
// MEETS SPECIFICATION:
// ... NOT

// B.
// CRITERIA:
// MEETS SPECIFICATION:
// ... NOT

