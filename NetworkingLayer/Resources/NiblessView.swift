//
//  NiblessView.swift
//  NetworkingLayer
//
//  Created by Abiu Ramirez on 21/02/25.
//

import UIKit

class NiblessView: UIView {

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection")

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
