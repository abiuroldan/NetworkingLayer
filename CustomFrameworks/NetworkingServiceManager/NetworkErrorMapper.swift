//
//  NetworkErrorMapper.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 09/03/25.
//

enum NetworkErrorMapper {
    static func map(_ error: Error) -> NetworkError {
        switch error {
        case let urlError as URLError:
            return .requestFailed(urlError)
        case let decodingError as DecodingError:
            return .decodingFailed(decodingError)
        case let networkError as NetworkError:
            return networkError
        case let encodingError as EncodingError:
            return .encodingFailed(encodingError)
        default: return .invalidResponse
        }
    }
}
