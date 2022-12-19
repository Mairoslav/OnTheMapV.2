//
//  LoginViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import UIKit

// A.1. the app has a login view that accepts email and password strings from users
class LoginViewController: UIViewController {
 
    // MARK: outlets for textFields, buttons and activityIndicator
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: loginTapped
    @IBAction func loginTapped(_ sender: UIButton) {
        deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: true)
        // call to login method declared in ClientUdacityApi.swift
        ClientUdacityApi.login(email: self.emailTextField.text ?? "defaultNil", password: self.passwordTextField.text ?? "defaultNil", completion: completeLoginResponse(success:error:))
    }
    
    // MARK: loginViaWebsiteTapped
    @IBAction func loginViaWebsiteTapped(_ sender: Any) {
        deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: true)
        // ...
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // tap outside of the pop-up keybord to dismiss it via .endEditing
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        print("🔳 LoginViewController was Loaded")
    }
    
    // MARK: completeLoginResponse
    func completeLoginResponse(success: Bool, error: Error?) {
        deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: false)
        if success {
            self.performSegue(withIdentifier: "completeLogin", sender: nil)
            print("🔳 Logging in was successful")
        } else {
            showAlertMessage(title: "Login Failed", message: error?.localizedDescription ?? "defaultNil") // A.2. app informs the user if the login fails and differentiates between a failure to connect/incorrect credentials thanks to .localizedDescription
            print("🔳 Logging in failed due to no connection or incorrect credentials - see Alert message")
        }
    }
    
    // MARK: deActivateTextFieldsAndActivityIndicator
    func deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: Bool) {
        // acitivity indicator does spin when loggingInIsOngoing is true
        if loggingInIsOngoing {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        // text fields and button are enabled when loggingInIsOngoing if false, negated by !
        self.emailTextField.isEnabled = !loggingInIsOngoing
        self.passwordTextField.isEnabled = !loggingInIsOngoing
        self.loginButton.isEnabled = !loggingInIsOngoing
    }
    
    
    
}

