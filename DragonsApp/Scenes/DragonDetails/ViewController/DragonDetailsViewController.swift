//
//  DragonDetailsViewController.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 15/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit

final class DragonDetailsViewController: UIViewController {
    private(set) lazy var baseView: DragonDetailsView = {
        let view = DragonDetailsView()
        view.dragonImageView.kf.setImage(with: viewModel.dragonImageUrl,
                                         placeholder: UILabel(text: viewModel.imagePlaceholderTitle))
        view.descriptionLabel.text = viewModel.dragonDescription
        view.ageLabel.text = viewModel.dragonAge
        view.greetingButton.addTarget(self, action: #selector(didPressGreetingButton), for: .touchUpInside)
        return view
    }()
    
    let viewModel: DragonDetailsViewModelProtocol
    
    init(viewModel: DragonDetailsViewModelProtocol) {
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
        title = viewModel.navigationTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configBind()
    }
    
    // MARK: - Functions
    private func configBind() {
        viewModel.greetingType.bind { [weak self] greetingType in
            guard let self = self, let greetingType = greetingType else { return }
            self.showAlert(message: greetingType.greeting)
        }
    }
    
    // MARK: - Actions
    @objc private func didPressGreetingButton() {
        viewModel.didPressGreetButton()
    }
}
