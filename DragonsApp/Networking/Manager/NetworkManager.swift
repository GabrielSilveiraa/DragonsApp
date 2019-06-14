//
//  NetworkManager.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
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

typealias NetworkCompletion<T> = (_ response: Result<T, Error>) -> Void

protocol NetworkManagerProtocol: AnyObject {
    func request<T: Decodable>(_ route: EndPointType, completion: @escaping NetworkCompletion<T>)
}

class NetworkManager {
    private var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    private func buildRequest(from route: EndPointType) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        return request
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponse {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkError.authenticationError)
        case 501...599: return .failure(NetworkError.badRequest)
        case 600: return .failure(NetworkError.outdated)
        default: return .failure(NetworkError.failed)
        }
    }
}

extension NetworkManager: NetworkManagerProtocol {
    func request<T: Decodable>(_ route: EndPointType, completion: @escaping NetworkCompletion<T>) {
        var task: URLSessionTask?
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    completion(.failure(NetworkError.noConnection))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.noResponse))
                    return
                }
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    do {
                        let jsonResponse = try JSONDecoder().decode(T.self, from: responseData)
                        completion(.success(jsonResponse))
                    } catch {
                        completion(.failure(NetworkError.unableToDecode))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        } catch {
            completion(.failure(error))
        }
        task?.resume()
    }
}
