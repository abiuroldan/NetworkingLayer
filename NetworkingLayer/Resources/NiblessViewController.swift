//
//  NiblessViewController.swift
//  NetworkingLayer
//
//  Created by Abiu Ramirez on 21/02/25.
//

import UIKit

open class NiblessViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
