//
//  Dragon.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

struct DragonsWrapper: Decodable {
    let success: Bool
    let dragons: [Dragon?]
}

struct Dragon: Decodable {
    let title: String?
}
