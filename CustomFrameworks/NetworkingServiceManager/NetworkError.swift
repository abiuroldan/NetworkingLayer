//
//  NetworkError.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

public enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case badRequest
    case unauthorized
    case forbidden
    case requestTimeOut
    case notFound
    case serverError
    case badGatway
    case unknownError(statusCode: Int)
    case invalidResponse
    case encodingFailed(Error)
    case decodingFailed(Error)
    case dataNotFound
}
