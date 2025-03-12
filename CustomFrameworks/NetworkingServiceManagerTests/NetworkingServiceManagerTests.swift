//
//  NetworkingServiceManagerTests.swift
//  NetworkingServiceManagerTests
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

import Combine
@testable import NetworkingServiceManager
import Testing

struct NetworkManagerTests {
    @Test func pokemonList() throws {
        let dataDecoded: PokemonList = try readFile(name: "PokemonList", forExtension: "json")
        let unwrappedJson = try #require(dataDecoded)
        #expect(unwrappedJson.count == 1304)
        #expect(unwrappedJson.results.count == 20)
        #expect(unwrappedJson.next == "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20")
        #expect(unwrappedJson.previous == nil)
    }
    
    @Test func emptyPokemonList() throws {
        let bundle = Bundle.main
        let url = try #require(bundle.url(forResource: "EmptyJsonResponse", withExtension: "json"))
        let data = try Data(contentsOf: url)
        #expect(throws: NetworkError.self) {
            _ = try data.decode(PokemonList.self)
        }
    }
    
    @Test func secondPageList() throws {
        let dataDecoded: PokemonList = try readFile(name: "SecondPageResponse", forExtension: "json")
        let unwrappedJson = try #require(dataDecoded)
        #expect(unwrappedJson.count == 1304)
        #expect(unwrappedJson.next == "https://pokeapi.co/api/v2/pokemon/?offset=40&limit=20")
        #expect(unwrappedJson.previous == "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20")
        #expect(unwrappedJson.results.count == 20)
    }
    
    @Test func pokemonItemList() throws {
        let dataDecoded: PokemonList = try readFile(name: "PokemonList", forExtension: "json")
        let unwrappedJson = try #require(dataDecoded)
        let firstItem = try #require(unwrappedJson.results.first)
        #expect(firstItem.name == "bulbasaur")
        #expect(firstItem.url == "https://pokeapi.co/api/v2/pokemon/1/")
    }

    @Test func perfomBECall() async throws {
        var cancellable: Set<AnyCancellable> = []
        let net = NetworkManagerMock(fileName: "PokemonList", fileExtension: "json")
        let networkManagerAPIMock = NetworkManagerAPIService(network: net)
        let publisher: AnyPublisher<PokemonList, NetworkError> = try await networkManagerAPIMock.fetchPokemonList(request: .full)
        publisher
            .sink { _ in
                
            } receiveValue: { data in
                #expect(data.count == 1304)
                #expect(data.results.count == 20)
                #expect(data.next == "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20")
                #expect(data.previous == nil)
            }
            .store(in: &cancellable)
    }
}

extension NetworkManagerTests {
    func readFile<T: Decodable>(name: String, forExtension: String) throws -> T {
        let bundle = Bundle.main
        let url = try #require(bundle.url(forResource: name, withExtension: forExtension))
        let data = try Data(contentsOf: url)
        let jsonDecoded = try data.decode(T.self)
        let unwrappedJson = try #require(jsonDecoded)
        return unwrappedJson
    }
}

extension AsyncSequence {
    func first() async rethrows -> Element? {
        try await first(where: { _ in true })
    }
}
