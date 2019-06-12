//
//  DragonsListService.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

protocol DragonsListServiceProtocol: AnyObject {
    func getDragonsList(completion: @escaping (Result<[Dragon], Error>) -> Void)
}

class DragonsListService {
    let networkManager = NetworkManager()
}

extension DragonsListService: DragonsListServiceProtocol {
    func getDragonsList(completion: @escaping (Result<[Dragon], Error>) -> Void) {
        let endPoint = DragonApi.dragonsList
        networkManager.request(endPoint) { (result: Result<DragonsWrapper, Error>) in
            switch result {
            case .success(let dragonsWrapper):
                guard dragonsWrapper.success else { return }
                let dragons = dragonsWrapper.dragons.compactMap {$0?.title != nil}
                print(dragons)
            case .failure(let error):
                print(error)
            }
        }
    }
}
