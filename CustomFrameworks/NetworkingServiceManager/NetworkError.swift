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
    case noResponse
    case encodingFailed(Error)
    case decodingFailed(Error)
    case dataNotFound
    case tooManyRequests
    case serviceUnavailable
    case gatewayTimeout
}

// MARK: - NetworkError Helper
extension NetworkError {
    static func from(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 408: return .requestTimeOut
        case 429: return .tooManyRequests
        case 500: return .serverError
        case 502: return .badGatway
        case 503: return .serviceUnavailable
        case 504: return .gatewayTimeout
        default: return .unknownError(statusCode: statusCode)
        }
    }
}
