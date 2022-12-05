//
//  UIViewController+Extension.swift
//  OnTheMapV.2
//
//  Created by mairo on 05/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    // ...
    
    // MARK: helper methods
    
    func showAlertMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
