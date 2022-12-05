//
//  LoginViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import UIKit

class LoginViewController: UIViewController {
 
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        setLoggingIn(true)
        // ... continue with ClientUdacityApi.login
    }
    
    @IBAction func loginViaWebsiteTapped(_ sender: Any) {
        performSegue(withIdentifier: "completeLogin", sender: nil)
    }
    
    // MARK: helper function 1
    func handleLoginResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        if success {
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showAlertMessage(title: "Login Failed", message: error?.localizedDescription ?? "Email or Password are not correct")
        }
    }
    
    // MARK: helper function 2
    // helper function for start/stop activityIndicator & en/dis-able login fields and buttons
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        // while logging in and spinning the activityIndicator,  are disabled
        // is not! enabled when loggin in
        self.emailTextField.isEnabled = !loggingIn
        self.passwordTextField.isEnabled = !loggingIn
        self.loginButton.isEnabled = !loggingIn
    }
    
    
    
}

