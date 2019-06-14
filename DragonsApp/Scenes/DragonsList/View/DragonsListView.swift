//
//  DragonsListView.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit
import SnapKit

final class DragonsListView: BaseView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DragonsListTableViewCell.self,
                           forCellReuseIdentifier: DragonsListTableViewCell.identifier)
        return tableView
    }()
    
    override func initialize() {
        addSubview(tableView)
    }
    
    override func setupConstraints() {
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
