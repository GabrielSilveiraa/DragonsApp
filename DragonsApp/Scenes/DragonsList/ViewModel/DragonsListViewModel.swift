//
//  DragonsListViewModel.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

protocol DragonsListViewModelProtocol: AnyObject {
    var dragonCells: Dynamic<[DragonsListCellViewModelProtocol]> { get }
}

final class DragonsListViewModel {
    private let service: DragonsListServiceProtocol
    private weak var navigationDelegate: DragonsListNavigationDelegate?
    var dragonCells: Dynamic<[DragonsListCellViewModelProtocol]> = Dynamic([])
    
    init(service: DragonsListServiceProtocol = DragonsListService(),
         navigationDelegate: DragonsListNavigationDelegate? = nil) {
        self.service = service
        self.navigationDelegate = navigationDelegate
        loadDragons()
    }
    
    private func loadDragons() {
        service.getDragonsList { (result: Result<[Dragon], Error>) in
            switch result {
            case .success(let dragons):
                self.dragonCells.value = dragons.map { DragonsListCellViewModel(model: $0) }
                
            case .failure(let error):
                break
            }
        }
    }
}

extension DragonsListViewModel: DragonsListViewModelProtocol {}
