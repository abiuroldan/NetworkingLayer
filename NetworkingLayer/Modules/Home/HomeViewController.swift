//
//  HomeViewController.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import UIKit

final class HomeViewController: NiblessViewController {
    private let rootView = HomeRootView()
    private let viewModel: HomeViewModelProtocol

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            if let url = URL(string: "pokemonapp://anything") {
//                if UIApplication.shared.canOpenURL(url) {
//                    UIApplication.shared.open(url)
//                }
//            }
//        }
    }
}
