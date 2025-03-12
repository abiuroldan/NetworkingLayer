//
//  ViewModel.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import Combine
import NetworkingServiceManager

final class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    let remoteAPI: RemoteServiceAPI
    var cancellables = Set<AnyCancellable>()
    @Published private(set) var list: FullLIstPokemon?
    var pokemonListPublisher: Published<FullLIstPokemon?>.Publisher {
        $list
    }

    init(remoteAPI: RemoteServiceAPI = RemoteService()) {
        self.remoteAPI = remoteAPI
    }

    private let isLoadingSubject = PassthroughSubject<Bool, Never>()
    var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }

    func fetchPokemonList() {
        isLoadingSubject.send(true)

        Task {
            do{
                try await remoteAPI.fetchPokemonList()
                    .sink { completion in
                        switch completion {
                        case .failure(let error):
                            print("Error: \(error)")
                        case .finished:
                            break
                        }
                    } receiveValue: { [weak self] list in
                        guard let self else { return }
                        self.isLoadingSubject.send(false)
                        self.list = list
                    }
                    .store(in: &cancellables)
            } catch {
                print("Error \(error)")
            }
        }
    }
}
