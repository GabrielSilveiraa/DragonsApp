//
//  Environment.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

final class Environment {
    private static let environmentFile = Bundle.main.path(forResource: "Environment", ofType: "plist")
    
    static var baseUrl: String = {
        guard let environmentFile = environmentFile,
            let environmentDictionary = NSDictionary(contentsOfFile: environmentFile),
            let url = environmentDictionary["URL_BASE"] as? String
            else {
                fatalError("URL_BASE not found in Environment.plist")
        }
        return url
    }()
}
