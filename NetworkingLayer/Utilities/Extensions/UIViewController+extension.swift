//
//  UIViewController+extension.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 12/03/25.
//

import UIKit

extension UIViewController {
    func showLoader() {
        if children.contains(where: { $0 is SpinnerViewController }) {
            print("Spnner already in main controller")
            return
        }

        let child = SpinnerViewController()
        addChild(child)
        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        child.didMove(toParent: self)
    }

    func hideLoader() {
        if let loader = children.first(where: { $0 is SpinnerViewController }) {
            loader.willMove(toParent: nil)
            loader.view.removeFromSuperview()
            loader.removeFromParent()
        }
    }
}
