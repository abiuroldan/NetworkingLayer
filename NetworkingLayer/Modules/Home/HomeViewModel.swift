//
//  ViewModel.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import Combine

final class HomeViewModel: HomeViewModelProtocol {
    let remoteAPI = RemoteService()

    private let isLoadingSubject = PassthroughSubject<Bool, Never>()
    var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }

    func requestList() {
        isLoadingSubject.send(true)
        remoteAPI.fullPokemonList { [weak self] result in
            guard let self else {
                return
            }
            self.isLoadingSubject.send(false)
            switch result {
            case .success(let list):
                print("Full pokemon list: ", list)
            case .failure(let error):
                print("request error: ", error)
            }
        }
    }
}
