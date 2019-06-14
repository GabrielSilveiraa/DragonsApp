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
    case authentication
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
            return "noConnectionError".localized
            
        case .failed:
            return "failedError".localized
            
        case .authentication:
            return "authenticationError".localized
            
        case .badRequest:
            return "badRequestError".localized
        
        case .outdated:
            return "outdatedError".localized
            
        case .noData:
            return "noDataError".localized
            
        case .noResponse:
            return "noResponseError".localized
            
        case .unableToDecode:
            return "unableToDecodeError".localized
        }
    }
}
