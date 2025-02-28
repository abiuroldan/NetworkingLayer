//
//  PokemonDetailViewController.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import UIKit
import Combine

protocol ViewModel {}

protocol PokemonDetailsProtocol: ViewModel {
    var pokemonPublisher: AnyPublisher<PokemonInfo, Never> { get }
    func updateUI()
}

final class PokemonDetailsViewModel: PokemonDetailsProtocol {
    private let pokemonSubject = PassthroughSubject<PokemonInfo, Never>()
    var pokemonPublisher: AnyPublisher<PokemonInfo, Never> {
        pokemonSubject.eraseToAnyPublisher()
    }
    private let pokemon: PokemonInfo
    
    init(_ pokemonData: PokemonInfo) {
        self.pokemon = pokemonData
    }

    func updateUI() {
        pokemonSubject.send(pokemon)
    }
}

final class PokemonDetailViewController: NiblessViewController {
    private let viewModel: PokemonDetailsProtocol
    private var cancellables = [AnyCancellable]()
    var rootView = UIView()
    
    override func loadView() {
        rootView.backgroundColor = .white
        view = rootView
    }
    init(viewModel: PokemonDetailsProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel
            .pokemonPublisher
            .sink { pokemon in
                print("✅ pokemon data received: \(pokemon)")
            }.store(in: &cancellables)

        viewModel.updateUI()
    }
}
