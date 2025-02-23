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
    }
    
    public func makeCall<T: Decodable>() async throws -> T {
        /// Configure the URL for our request.
        let url = URL(string: baseURL)!
        
        /// Use URLSession to fetch the data asynchronously.
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
