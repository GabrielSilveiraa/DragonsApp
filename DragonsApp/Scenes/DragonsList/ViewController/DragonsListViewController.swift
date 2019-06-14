//
//  DragonsListViewController.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit

final class DragonsListViewController: UIViewController {
    private(set) lazy var baseView: DragonsListView = {
        let view = DragonsListView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()
    
    let viewModel: DragonsListViewModelProtocol
    
    init(viewModel: DragonsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configBind()
    }
    
    private func configBind() {
        viewModel.dragonCells.bind { [weak self] _ in
            guard let self = self else { return }
            self.baseView.tableView.reloadData()
        }
        
        viewModel.loading.bindAndFire { [weak baseView] isLoading in
            guard let baseView = baseView else { return }
            isLoading ? baseView.activityIndicator.startAnimating() : baseView.activityIndicator.stopAnimating()
        }
        
        viewModel.error.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            self.showAlert(message: error)
        }
    }
}

extension DragonsListViewController: UITableViewDelegate {
    
}

extension DragonsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dragonCells.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DragonsListTableViewCell.identifier,
                                                       for: indexPath) as? DragonsListTableViewCell else {
                                                        return UITableViewCell()
        }
        let cellViewModel = viewModel.dragonCells.value[indexPath.row]
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}
