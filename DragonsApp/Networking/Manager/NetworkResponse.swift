//
//  NetworkResponse.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 14/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

enum NetworkResponse {
    case success
    case failure(NetworkError)
}

enum NetworkError: Error {
    case noConnection
    case failed
    case authenticationError
    case badRequest
    case outdated
    case noData
    case noResponse
    case unableToDecode
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noConnection:
            return ""
        default:
            return ""
        }
    }
}
