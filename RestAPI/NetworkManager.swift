//
//  NetworkManager.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 22/02/25.
//

public class NetworkManager {
    public init() {}

    public func configuration() {
        print("Networking configuration loading...")
        Task(priority: .background) {
            do {
                let result: PokemonList = try await makeCall()
                print(result)
            } catch {
                print("Error: \(error)")
            }
        }
    }

    private func makeCall<T: Decodable>() async throws -> T {
        /// Configure the URL for our request.
        guard let url = URL(string: baseURL) else {
            fatalError("Empty URL")
        }

        /// Use URLSession to fetch the data asynchronously.
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
