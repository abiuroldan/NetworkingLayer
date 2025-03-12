//
//  Encodable+extension.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 09/03/25.
//

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NetworkError.encodingFailed(NSError(domain: "Encoding Error", code: -1))
        }
        return dictionary
    }

    func encodeBody() throws -> Data {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            throw NetworkError.encodingFailed(error)
        }
    }
}
