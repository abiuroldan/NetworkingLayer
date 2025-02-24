//
//  HomeViewController.swift
//  NetworkingLayer
//
//  Created by Abiu Ramirez on 21/02/25.
//

import UIKit
import RestAPI

final class HomeViewController: NiblessViewController {
    @Injected(\.networkProvider) var networkProvider: PokemonListRemote

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Task(priority: .background) {
            await networkProvider.fullPokemonList(type: PokemonList.self, request: .fullLIst) { response in
                guard let response else {
                    print("no response")
                    return
                }
                print("Response from BE \(response)")
            }
        }
    }
}
