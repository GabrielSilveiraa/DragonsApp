//
//  DragonsListTableViewCell.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit

final class DragonsListTableViewCell: UITableViewCell {
    static let identifier = "DragonsListTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .blackWithAlpha
        textLabel?.textColor = .white
        textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: DragonsListCellViewModelProtocol) {
        textLabel?.text = viewModel.dragonTitle
    }

}
