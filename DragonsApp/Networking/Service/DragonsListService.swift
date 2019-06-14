//
//  DragonsListService.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

enum DragonsListServiceError: Error, Equatable {
    case requestFailed
}

extension DragonsListServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return ""
        }
    }
}

protocol DragonsListServiceProtocol: AnyObject {
    func getDragonsList(completion: @escaping (Result<[Dragon], Error>) -> Void)
}

class DragonsListService {
    let networkManager: NetworkManager
    
    init(session: URLSession = .shared) {
        networkManager = NetworkManager(session: session)
    }
}

extension DragonsListService: DragonsListServiceProtocol {
    func getDragonsList(completion: @escaping (Result<[Dragon], Error>) -> Void) {
        let endPoint = DragonApi.dragonsList
        networkManager.request(endPoint) { (result: Result<DragonsWrapper, Error>) in
            switch result {
            case .success(let dragonsWrapper):
                guard dragonsWrapper.success else {
                    completion(.failure(DragonsListServiceError.requestFailed))
                    return
                }
                let dragons = dragonsWrapper.dragons.filter {$0?.title != nil}.compactMap {$0}
                completion(.success(dragons))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
