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
    var loading: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }
}

final class DragonsListViewModel {
    private let service: DragonsListServiceProtocol
    private weak var navigationDelegate: DragonsListNavigationDelegate?
    var dragonCells: Dynamic<[DragonsListCellViewModelProtocol]> = Dynamic([])
    var loading: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
    
    init(service: DragonsListServiceProtocol = DragonsListService(),
         navigationDelegate: DragonsListNavigationDelegate? = nil) {
        self.service = service
        self.navigationDelegate = navigationDelegate
        loadDragons()
    }
    
    private func loadDragons() {
        loading.value = true
        service.getDragonsList { (result: Result<[Dragon], Error>) in
            self.loading.value = false
            switch result {
            case .success(let dragons):
                self.dragonCells.value = dragons.map { DragonsListCellViewModel(model: $0) }
                
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}

extension DragonsListViewModel: DragonsListViewModelProtocol {}
