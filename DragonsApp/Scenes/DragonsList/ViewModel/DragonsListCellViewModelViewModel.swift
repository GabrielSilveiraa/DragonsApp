//
//  DragonsListCellViewModelViewModel.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 14/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

protocol DragonsListCellViewModelProtocol: AnyObject {
    var dragonTitle: String { get }
}

class DragonsListCellViewModel {
    private let dragon: Dragon
    
    init(model: Dragon) {
        dragon = model
    }
}

extension DragonsListCellViewModel: DragonsListCellViewModelProtocol {
    var dragonTitle: String {
        return dragon.title ?? ""
    }
}
