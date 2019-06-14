//
//  DragonsListViewModel.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

protocol DragonsListViewModelProtocol: AnyObject {
    
}

final class DragonsListViewModel {
    private let service: DragonsListServiceProtocol
    private weak var navigationDelegate: DragonsListNavigationDelegate?
    
    init(service: DragonsListServiceProtocol = DragonsListService(),
         navigationDelegate: DragonsListNavigationDelegate? = nil) {
        self.service = service
        self.navigationDelegate = navigationDelegate
    }
}

extension DragonsListViewModel: DragonsListViewModelProtocol {}
