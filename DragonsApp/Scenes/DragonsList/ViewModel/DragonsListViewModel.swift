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
    var navigationTitle: String { get }
    
    func didSelect(row: Int)
}

class DragonsListViewModel {
    private let service: DragonsListServiceProtocol
    private weak var navigationDelegate: DragonsListNavigationDelegate?
    var dragonCells: Dynamic<[DragonsListCellViewModelProtocol]> = Dynamic([])
    var loading: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
    private var dragons: [Dragon] = []
    
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
                self.dragons = dragons
                self.dragonCells.value = dragons.map { DragonsListCellViewModel(model: $0) }
                
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}

extension DragonsListViewModel: DragonsListViewModelProtocol {
    var navigationTitle: String {
        return "dragonsListTitle".localized
    }
    
    func didSelect(row: Int) {
        let dragon = dragons[row]
        if Thread.isMainThread {
            navigationDelegate?.goToDragonDetails(dragon: dragon)
        } else {
            DispatchQueue.main.async {
                self.navigationDelegate?.goToDragonDetails(dragon: dragon)
            }
        }
    }
}
