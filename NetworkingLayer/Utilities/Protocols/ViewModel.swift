//
//  ViewModel.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 28/02/25.
//

import Combine

protocol ViewModel {
    var isLoading: AnyPublisher<Bool, Never> { get }
}
