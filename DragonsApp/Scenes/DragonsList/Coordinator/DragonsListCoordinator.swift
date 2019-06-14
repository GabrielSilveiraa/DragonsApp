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
    }
}

extension DragonsListCoordinator: DragonsListNavigationDelegate {
    func goToDragonDetails() {
        
    }
}
