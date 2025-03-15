//
//  LoaderView.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 12/03/25.
//

import UIKit

final class SpinnerViewController: NiblessViewController {
    let spinner = UIActivityIndicatorView(style: .large)

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SpinnerView accessibilityIdentifier:", spinner.accessibilityIdentifier ?? "nil")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .loaderBackground

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityIdentifier = "SpinnerView" 
        view.addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        spinner.color = .loader
        spinner.startAnimating()
    }
}
