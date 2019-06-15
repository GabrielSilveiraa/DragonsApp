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

enum GreetingType: String, Decodable {
    case gr, roar, groar, whoa
    
    var greeting: String {
        switch self {
        case .roar:
            return "Roarrrrrrrr!"
        
        case .groar:
            return "Groarrrrrrr!"
            
        case .gr:
            return "Grrrrrrrrrrr!"
            
        case .whoa:
            return "Whoaaaaaaa"
        }
    }
}

struct Dragon {
    let id, age: Int
    let description: String
    let title, image: String?
    let greetingType: GreetingType
}

extension Dragon: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, title, description, age, image
        case greetingType = "greeting_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.age = try container.decode(Int.self, forKey: .age)
        self.description = try container.decode(String.self, forKey: .description)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.greetingType = try container.decodeIfPresent(GreetingType.self, forKey: .greetingType) ?? .gr
    }
}

extension Dragon: Equatable {}
