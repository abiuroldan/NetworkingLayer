//
//  APIRouter.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 23/02/25.
//

public enum APIRouter: NetworkRequest {
    case fullLIst
    case byName(String)
    case byId(String)

    internal var url: URL? {
        switch self {
        case .byName(let name):
            return URL(string: "\(GlobalSettings.baseAPIURL)/\(name)")
        case .byId(let id):
            return URL(string: "\(GlobalSettings.baseAPIURL)/\(id)")
        default:return URL(string: GlobalSettings.baseAPIURL)
        }
    }

    internal var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }

    // By default, this will be updated
    internal var headers: [ String: String]? {
        ["Content-Type": "application/json"]
    }

    // No need it for now, this will be updated
    internal var parameters: Encodable? {
        nil
    }
}
