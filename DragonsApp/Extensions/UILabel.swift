//
//  UILabel.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 15/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit
import Kingfisher

enum FontType {
    case system, bold
    
    func font(size: CGFloat) -> UIFont {
        switch self {
        case .system: return UIFont.systemFont(ofSize: size)
        case .bold: return UIFont.boldSystemFont(ofSize: size)
        }
    }
}

extension UILabel {
    convenience init(fontType: FontType = .system,
                     alignment: NSTextAlignment = .left,
                     size: CGFloat = 16,
                     textColor: UIColor = .black,
                     text: String = "") {
        self.init()
        self.textAlignment = alignment
        self.textColor = textColor
        self.font = fontType.font(size: size)
        self.text = text
    }
}

extension UILabel: Placeholder {
    public func add(to imageView: ImageView) {
        imageView.addSubview(self)
        self.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    public func remove(from imageView: ImageView) {
        self.removeFromSuperview()
    }
}
