//
//  UIViewController+extensions.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, _ completion: @escaping (() -> ())) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {_ in 
            completion()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}
