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
        //Config the binds to viewModel here
    }
}
