//
//  Data+extension.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

import Foundation

extension Data {
    public func decode<T: Decodable>(_ type: T.Type) throws -> T {
        do {
            let decoder = JSONDecoder(isSnakeCaseConverting: true)
            let dataDecoded = try decoder.decode(T.self, from: self)
            return dataDecoded
        } catch let decodingError {
            throw NetworkError.decodingFailed(decodingError)
        }
    }
}
