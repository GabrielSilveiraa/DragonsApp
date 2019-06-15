//
//  DragonsListCoordinator.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit

protocol DragonsListNavigationDelegate: AnyObject {
    func goToDragonDetails()
}

class DragonsListCoordinator {
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DragonsListCoordinator: Coordinator {
    func start() {
        let viewModel = DragonsListViewModel(navigationDelegate: self)
        let viewController = DragonsListViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}

extension DragonsListCoordinator: DragonsListNavigationDelegate {
    func goToDragonDetails() {
        
    }
}
