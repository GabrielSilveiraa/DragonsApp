//
//  BaseView.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit
/**
    **Contains the inteface elements of a screen or screen fragment**
    Contains labels, buttons, etc and is responsible for the layout.
    **Lifecycle:**
    1. `init()`
    2. `initialize()` *Add subviews*
    3. `installConstraints()` *Layout*
    - The methods themselves do nothing, it's up to the custom implementation
 */
class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    required init() {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    /// Default implementation does nothing
    func initialize() { fatalError("Must be overridden") }
    
    /// Default implementation does nothing
    func installConstraints() { fatalError("Must be overridden") }
    
    private func setup() {
        self.initialize()
        self.installConstraints()
    }
}
