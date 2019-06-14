//
//  DragonEndPoint.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

enum DragonApi {
    case dragonsList
}

extension DragonApi: EndPointType {
    var baseURL: URL {
         guard let url = URL(string: Environment.baseUrl) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .dragonsList:
            return "/dragoslist"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return .urlEncoding
    }
    
    var parameters: [String : Any] {
        switch self {
        case .dragonsList:
            return [:]
        }
    }
}
