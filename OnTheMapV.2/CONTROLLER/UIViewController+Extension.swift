//
//  UIViewController+Extension.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: addPinTapped
    @IBAction func addPinTapped(_ sender: UIBarButtonItem) {
        let locationPosted = ClientUdacityApi.Auth.objectId != ""
        
        if locationPosted {
            // if user alrady added pin, he can overwrite it or cancel the current action
            let overwrite = UIAlertAction(title: "Overwrite", style: .default) { (action) in
                self.overwriteLocation(toOverwrite: true) // yet to toOverwrite because pinAlreadyPosted
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            // alert to inform that location has been already posted
            let locationPostedAlert = UIAlertController(title: nil, message: "You have already posted your Location. Do you want to overwrite your current Location?", preferredStyle: .alert)
            locationPostedAlert.addAction(overwrite)
            locationPostedAlert.addAction(cancel)
            present(locationPostedAlert, animated: true, completion: nil)
        } else {
            overwriteLocation(toOverwrite: false) // not toOverwrite because pinAlreadyPosted is false 
        }
    }
    
    // MARK: refreshStudenPosts
    @IBAction func refreshStudentPosts(_ sender: UIBarButtonItem) {
        ClientUdacityApi.getStudentInformation { studentLocation, error in
            if error ==  nil {
                studentInformationModel.studentLocation = studentLocation
            } else {
                self.showAlertMessage(title: "Data Refresh Failed", message: "Unable to Refresh Students Information")
            }
        }
    }
    
    // MARK: overwriteLocation
    func overwriteLocation(toOverwrite: Bool) {
        ClientUdacityApi.Auth.pinAlreadyPosted = toOverwrite
        self.performSegue(withIdentifier: "addLocation", sender: nil)
    }
        

    // MARK: openURLLink
    func openURLLink(urlString: String?) {
        guard let urlString = urlString else {
            showAlertMessage(title: "Cannot open", message: "No web-site provided")
            return
        }
        
        let urlProvided = URL(string: urlString)
        
        if let urlProvided = urlProvided {
            let validUrl: Bool = UIApplication.shared.canOpenURL(urlProvided)
            if validUrl {
                DispatchQueue.main.async {
                    UIApplication.shared.open(urlProvided, options: [:], completionHandler: nil)
                }
            } else {
                showAlertMessage(title: "Cannot open", message: "Not valid url")
            }
        } else {
            showAlertMessage(title: "Cannot open", message: "Url not provided")
        }
    }
    
    // MARK: alert message
    func showAlertMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: logout
    @IBAction func logoutTapped(_sender: UIBarButtonItem) {
        ClientUdacityApi.logout { success, error in
            if success {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginViewController = storyboard.instantiateViewController(withIdentifier: "loginView")
                LoginViewController.modalPresentationStyle = .fullScreen
                self.present(LoginViewController, animated: true)
            } else {
                self.showAlertMessage(title: "Logout Failed", message: error?.localizedDescription ?? "")
            }
        }
    }
    
}
