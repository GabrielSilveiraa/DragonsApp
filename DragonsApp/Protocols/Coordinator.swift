//
//  Coordinator.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func add(childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    func remove(childCoordinator: Coordinator) {
        childCoordinators.removeAll { $0 === childCoordinator }
    }
}
