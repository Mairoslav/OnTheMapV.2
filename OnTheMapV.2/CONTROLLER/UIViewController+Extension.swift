//
//  UIViewController+Extension.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation
import UIKit
import FBSDKLoginKit

extension UIViewController {
    
    // MARK: addPinTapped
    // B.14. pin button in the navigation bar allow users to post their own information to the server
    @IBAction func addPinTapped(_ sender: UIBarButtonItem) {
        print("🔳 addPinTapped")
        // locationAlreadyPosted is true in case of non empty String without objectId
        let locationAlreadyPosted = ClientUdacityApi.Auth.objectId != ""
        
        if locationAlreadyPosted {
            // if true, user can A) overwrite it within UIAlertAction pop-up window
            let overwriteLocation = UIAlertAction(title: "Overwrite", style: .default) { action in
                self.overwriteLocation(yesOverwrite: true) // overwrite is enabled*
                print("🔳 Location has been already posted in this session ~ overwrite location was enabled, adding new location is initiated in AddLocationViewController")
            }
            // B) or keep current location via canceling the current action
            let keepLocation = UIAlertAction(title: "Keep", style: .cancel) { action in
                // no code, only Alert pop-up window is closed when option "Keep" is chosen
                print("🔳 Location is kept")
            }
            
            // alert pop-up window to inform that location has been already posted
            let locationAlreadyPostedAlertPopUp = UIAlertController(title: "You have already posted your Location", message: "Do you want to keep or overwrite your current Location?", preferredStyle: .alert)
            locationAlreadyPostedAlertPopUp.addAction(overwriteLocation)
            locationAlreadyPostedAlertPopUp.addAction(keepLocation)
            present(locationAlreadyPostedAlertPopUp, animated: true, completion: nil)
        } else {
            overwriteLocation(yesOverwrite: false) // no overwrite**
            print("🔳 No location has been posted in this session ~ nothing to overwrite, adding new location is initiated in AddLocationViewController")
            
        }
    }
    
    // MARK: refreshStudenPosts
    @IBAction func refreshStudentPosts(_ sender: UIBarButtonItem) {
        ClientUdacityApi.getStudentInformation { studentLocation, error in
            if error == nil {
                StudentInformationModel.studentLocation = studentLocation // this refresh is already done in MapTabbedViewController, see comment B.11. Only makes sense to press refresh button in case to check whether any other students did post new locations since the time that user is logged in and if MapTabbedViewController was not selected in TabbedView or instantiate after adding new location.
                print("🔳 Students posts were refreshed")
            } else {
                self.showAlertMessage(title: "Data Refresh Failed", message: error?.localizedDescription ?? "defaultNil")
            }
        }
    }
    
    // MARK: overwriteLocation
    func overwriteLocation(yesOverwrite: Bool) {
        // if yesOverwrite is true, locationAlreadyPosted is set from default false to true (overwrite is enabled*)
        // if yesOverwrite is false, locationAlreadyPosted is kept false as set by default in "ClientUdacityApi.swift" (no overwrite**)
        ClientUdacityApi.Auth.locationAlreadyPosted = yesOverwrite
        // in both cases there is transition from Map/Table-TabbedView to AddLocationViewController via "addLocation" Storyboard Segue
        self.performSegue(withIdentifier: "addLocation", sender: nil)
    }
        

    // MARK: openURLLink
    // B.9. If the pin annotation is tapped, is the link opened in Safari
    func openURLLink(urlString: String?) {
        guard let urlString = urlString else {
            return
        }
        
        let urlProvided = URL(string: urlString) // ?? "url is nil") // without  guard let above need to use Coalescing here
        
        if let urlProvided = urlProvided {
            let validUrl: Bool = UIApplication.shared.canOpenURL(urlProvided)
            if validUrl {
                DispatchQueue.main.async {
                    UIApplication.shared.open(urlProvided, options: [:], completionHandler: nil)
                    print("🔳 Url was opened")
                }
            } else {
                showAlertMessage(title: "Not valid Url", message: "Provided Url is not valid ")
            }
        } else {
            showAlertMessage(title: "No Url", message: "No Url was provided by User")
        }
    }
    
    // MARK: alert message
    func showAlertMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: logout
    // B.16. The logout button causes the Student Locations Tabbed View to dismiss, and logs out of the current session.
    @IBAction func logoutTapped(_sender: UIBarButtonItem) {
        // logout method declared in ClientUdacityApi.swift needs to be called to log out of the current session ~ full and secure logout
        ClientUdacityApi.logout { success, error in
            // if log out of the current session successful, LoginViewController is presented
            if success {
                
                let loginManager = LoginManager()
                if let _ = AccessToken.current {
                    // if user is loggedIn go ahead with logOut
                    loginManager.logOut()
                }
                
                // transition to LoginViewController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginViewController = storyboard.instantiateViewController(withIdentifier: "loginView")
                LoginViewController.modalPresentationStyle = .fullScreen
                self.present(LoginViewController, animated: true)
                print("🔳 Logged Out successfuly") 
            } else {
                self.showAlertMessage(title: "Logout Failed", message: error?.localizedDescription ?? "defaultNil")
            }
        }
    }
    
}
