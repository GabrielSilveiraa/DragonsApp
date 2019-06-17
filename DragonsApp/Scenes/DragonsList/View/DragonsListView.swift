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
        tableView.backgroundColor = .blackWithAlpha
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        return activityIndicator
    }()
    
    override func initialize() {
        addSubview(tableView)
        addSubview(activityIndicator)
    }
    
    override func setupConstraints() {
        setupTableViewConstraints()
        setupActivityIndicatorConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupActivityIndicatorConstraints() {
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
