//
//  HomeViewController.swift
//  NetworkingLayer
//
//  Created by Abiu Ramirez on 21/02/25.
//

import Combine
import UIKit
import RestAPI

final class HomeViewController: NiblessViewController {
    let rootView = HomeRootView()
    private var cancellables = [AnyCancellable]()
    private let viewModel: HomeViewModelAPI
    
    init(viewModel: HomeViewModelAPI) {
        self.viewModel = viewModel
        super.init()
    }

    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        rootView.buttonTapped = { [weak self] in
            guard let self,
                  let text = rootView.getText(),
                  !text.isEmpty else {
                self?.showAlert(title: "no empty pokemon", message: "please add pokemon name") {}
                return
            }
            viewModel.searchBy(name: text)
        }
    }
}
