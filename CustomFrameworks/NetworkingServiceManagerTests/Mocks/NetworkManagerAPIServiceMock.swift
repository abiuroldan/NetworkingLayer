//
//  NetworkManagerAPIServiceMock.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 02/03/25.
//

import Combine
import NetworkingServiceManager

final class NetworkManagerMock: NetworkingManagerService {
    let fileName: String
    let fileExtension: String

    init(fileName: String, fileExtension: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
    }

    func fetchData<T: Decodable>(_ request: any NetworkRequest, type: T.Type) throws -> AnyPublisher<T, NetworkError>{
        guard let data: T = try? readFile(name: fileName, forExtension: fileExtension) else {
            throw NetworkError.invalidResponse
        }
        return Just(data)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}

extension NetworkManagerMock {
    fileprivate func readFile<T: Decodable>(name: String, forExtension: String) throws -> T {
        guard let url = Bundle.main.url(forResource: name, withExtension: forExtension),
              let data = try? Data(contentsOf: url),
              let jsonDecoded = try? data.decode(T.self) else {
            throw NetworkError.invalidResponse
        }
        return jsonDecoded
    }
}
