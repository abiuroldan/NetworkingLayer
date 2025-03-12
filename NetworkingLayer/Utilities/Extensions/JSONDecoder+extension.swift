//
//  JSONDecoder+extension.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 09/03/25.
//

import Combine

extension JSONDecoder {
    static let snakeCaseConverting: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    convenience init(isSnakeCaseConverting: Bool = false) {
        self.init()
        keyDecodingStrategy = isSnakeCaseConverting ? .convertFromSnakeCase : .useDefaultKeys
    }
}

extension Publisher where Output == Data {
    func decode<T: Decodable>(
        as type: T.Type = T.self,
        using decoder: JSONDecoder = .snakeCaseConverting
    ) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}
