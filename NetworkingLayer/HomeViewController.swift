//
//  HomeViewController.swift
//  NetworkingLayer
//
//  Created by Abiu Ramirez on 21/02/25.
//

import UIKit
import RestAPI

final class HomeViewController: NiblessViewController {
    let manager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        manager.configuration()
    }
}
