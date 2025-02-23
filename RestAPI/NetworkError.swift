//
//  NetworkError.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 22/02/25.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case dataNotFound
    case decodingFailed(Error)
    case encodingFailed(Error)
    case notFound
    case internalServerError
    case unknownError(statusCode: Int)
}

struct DecodingError: Error {
    let message: String
}
