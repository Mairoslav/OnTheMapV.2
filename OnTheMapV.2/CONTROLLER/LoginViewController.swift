//
//  LoginViewController.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import UIKit
import FBSDKLoginKit
import SafariServices

// A.1. the app has a login view that accepts email and password strings from users
class LoginViewController: UIViewController {
 
    // MARK: outlets for textFields, buttons and activityIndicator
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // when the activity indicator is stopped it is hidden
        activityIndicator.hidesWhenStopped = true
        
        // tap outside of the pop-up keybord to dismiss it via .endEditing
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        debugPrint("🔳 LoginViewController was Loaded")
    }
    
    // MARK: loginTapped
    @IBAction func loginTapped(_ sender: UIButton) {
        deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: true)
        // call to login method declared in ClientUdacityApi.swift
        ClientUdacityApi.login(email: self.emailTextField.text ?? "defaultNil", password: self.passwordTextField.text ?? "defaultNil", completion: completeLoginResponse(success:error:))
    }
    
    // MARK: loginViaWebsiteTapped
    @IBAction func loginViaWebsiteTapped(_ sender: Any) {
        deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: true)
        loginViaFb(completion: completeLoginResponse(success:error:))
    }
    
    func loginViaFb(completion: @escaping (Bool, Error?) -> Void) {
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            // if token is current ~ user is loggedIn, go ahead with logOut()
            loginManager.logOut()
        } else {
            // go ahead with logIn
            loginManager.logIn(permissions: [], from: self) { [weak self] result, error in
                // guard that no error, otherwise async complete with error and return
                guard error == nil else {
                    self?.showAlertMessage(title: "Login with Fb Failed", message: "unknown error occured")
                    DispatchQueue.main.async {
                        completion(false, error)
                    }
                    return
                }
                // guard that result is not cancelled otherwise cancel activity indicator... and return
                guard let result = result, !result.isCancelled else {
                    self?.deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: false)
                    debugPrint("🔳 fb login was cancelled by user")
                    return
                }
                // if logIn successful
                DispatchQueue.main.async {
                    completion(true, nil)
                }
                
                Profile.loadCurrentProfile { profile, error in
                    ClientUdacityApi.Auth.firstName = "Mārtiņš Garanča"
                }
                
                debugPrint("🔳 Logging in via Fb was successful")
            }
        }
    }

    // MARK: completeLoginResponse
    func completeLoginResponse(success: Bool, error: Error?) {
        deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: false)
        if success {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MapTabbedViewController = storyboard.instantiateViewController(withIdentifier: "MapTabbedViewController")
            present(MapTabbedViewController, animated: true)
            debugPrint("🔳 Logging in was successful")
        } else {
            showAlertMessage(title: "Login Failed", message: error?.localizedDescription ?? "defaultNil") // A.2. app informs the user if the login fails and differentiates between a failure to connect/incorrect credentials thanks to .localizedDescription
            debugPrint("🔳 Logging in failed due to no connection or incorrect credentials - see Alert message")
        }
    }
    
    // MARK: deActivateTextFieldsAndActivityIndicator
    func deActivateTextFieldsAndActivityIndicator(loggingInIsOngoing: Bool) {
        // acitivity indicator does spin when loggingInIsOngoing is true
        loggingInIsOngoing ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
        // text fields and button are enabled when loggingInIsOngoing if false, negated by !
        emailTextField.isEnabled = !loggingInIsOngoing
        passwordTextField.isEnabled = !loggingInIsOngoing
        loginButton.isEnabled = !loggingInIsOngoing
    }
    
}

// facebook login view is opened via a webview, setting webview to .fullScreen
extension SFSafariViewController {
    override open var modalPresentationStyle: UIModalPresentationStyle {
        get { return .fullScreen}
        set { super.modalPresentationStyle = newValue}
    }
}
