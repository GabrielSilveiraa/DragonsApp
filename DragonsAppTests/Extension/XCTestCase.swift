//
//  XCTestCase.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadJson<T: Decodable>(filename fileName: String) -> T? {
        let bundle = Bundle.init(for: type(of: self))
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
