//
//  DragonDetailsViewModel.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 15/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

protocol DragonDetailsViewModelProtocol: AnyObject {
    var greetingType: Dynamic<GreetingType?> { get }
    var imagePlaceholderTitle: String { get }
    var dragonDescription: String { get }
    var navigationTitle: String { get }
    var dragonImageUrl: URL? { get }
    var dragonAge: String { get }
    
    func didPressGreetButton()
}

class DragonDetailsViewModel {
    private let dragon: Dragon
    var greetingType: Dynamic<GreetingType?> = Dynamic(nil)
    
    init(dragon: Dragon) {
        self.dragon = dragon
    }
}

extension DragonDetailsViewModel: DragonDetailsViewModelProtocol {
    var dragonImageUrl: URL? {
        return dragon.image
    }
    var navigationTitle: String {
        return dragon.title ?? ""
    }
    var imagePlaceholderTitle: String {
        return "noDragonImage".localized
    }
    var dragonDescription: String {
        return dragon.description
    }
    var dragonAge: String {
        return "\("age".localized): \(dragon.age)"
    }
    
    func didPressGreetButton() {
        greetingType.value = dragon.greetingType
    }
}
