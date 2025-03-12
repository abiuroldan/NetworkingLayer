//
//  HomeViewController.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import UIKit
import Combine

final class HomeViewController<model: HomeViewModelProtocol>: NiblessViewController {
    private let rootView = HomeRootView()
    private var viewModel: model

    init(viewModel: model) {
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
            .sink { _ in
                
            }
            .store(in: &viewModel.cancellables)

        viewModel.fetchPokemonList()

        viewModel.pokemonListPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            }
            .store(in: &viewModel.cancellables)
    }
}

