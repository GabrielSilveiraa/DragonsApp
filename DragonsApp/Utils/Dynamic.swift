//
//  Dynamic.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import Foundation

final class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    private(set) var listener: Listener?
    
    public var value: T {
        didSet {
            callListener()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        callListener()
    }
    
    func isBinded() -> Bool {
        return listener != nil
    }
    
    private func callListener() {
        //Jumping queues https://www.swiftbysundell.com/posts/reducing-flakiness-in-swift-tests
        if Thread.isMainThread {
            listener?(value)
        } else {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
}
