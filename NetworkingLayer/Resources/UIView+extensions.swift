//
//  UIView+extensions.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import UIKit

extension UIView {
    func addCustomSubviews(_ views: [UIView] ) {
        views.forEach { view in
            addCustomSubview(view)
        }
    }

    func addCustomSubview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
