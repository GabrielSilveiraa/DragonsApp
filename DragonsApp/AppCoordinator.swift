//
//  AppCoordinator.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit

class AppCoordinator {
    private let window: UIWindow
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController = {
        let navigation = UINavigationController()
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        let dragonsListCoordinator = DragonsListCoordinator(navigationController: navigationController)
        dragonsListCoordinator.start()
        add(childCoordinator: dragonsListCoordinator)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
