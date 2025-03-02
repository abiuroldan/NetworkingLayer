//
//  APIRequestType.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

public enum APIRequestType: NetworkRequest {
    var baseURL: String {
        "https://pokeapi.co/api/v2/pokemon/"
    }

    case full
    case byId(Int)
    case byName(String)

    internal var url: URL? {
        switch self {
        case .byId(let id):
            return URL(string: "\(baseURL)\(id)")
        case .byName(let name):
            return URL(string: "\(baseURL)\(name)")
        default:
            return URL(string: baseURL)
        }
    }

    internal var method: HttpMethod {
        switch self {
        default: return .get
        }
    }

    internal var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }

    internal var parameters: (any Encodable)? {
        nil
    }
}
