//
//  HomeViewModel.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import Combine
import Foundation

protocol HomeViewModelAPI: ViewModel {
    func apiFullList()
    func searchBy(name: String)
}

final class HomeViewModel: HomeViewModelAPI {
    private let remoteAPI = PokemonRemoteAPIImp()
    private let appCoordinator: AppCoordinatorProtocol
    
    init(appCoordinator: AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
    }
    
    func searchBy(name: String) {
        searchPokemonBy(name: name)
    }
    
    private func searchPokemonBy(name: String) {
        remoteAPI.searchBy(name: name) { [weak self] pokemonInfo in
            guard let self else {
                return
            }
            DispatchQueue.main.async {
                self.appCoordinator
                    .showPokemonDetailCoordinator(
                        pokemonInfo
                    )
            }
        }
    }
    
    func apiFullList() {
        remoteAPI.fullList { list in
            print("List ", list.count)
        }
    }
}
