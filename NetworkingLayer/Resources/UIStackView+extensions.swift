//
//  UIStackView+extensions.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView] ) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
