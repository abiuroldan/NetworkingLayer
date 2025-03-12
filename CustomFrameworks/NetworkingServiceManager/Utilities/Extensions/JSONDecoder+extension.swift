//
//  JSONDecoder+extension.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 09/03/25.
//

extension JSONDecoder {
    convenience init(isSnakeCaseConverting: Bool = false) {
        self.init()
        keyDecodingStrategy = isSnakeCaseConverting ? .convertFromSnakeCase : .useDefaultKeys
    }
}
