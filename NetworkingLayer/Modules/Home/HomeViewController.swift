//
//  HomeViewController.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import UIKit
import Combine

final class HomeViewController: NiblessViewController {
    private let rootView = HomeRootView()
    private let viewModel: HomeViewModelProtocol
    private var cancellables = [AnyCancellable]()

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel
            .isLoading
            .sink { isLoading in
                print(isLoading ? "isLoading..." : "done")
            }
            .store(in: &cancellables)

        viewModel.requestList()
    }
}
