//
//  DragonDetailsView.swift
//  DragonsApp
//
//  Created by Gabriel Silveira on 15/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import UIKit
import Kingfisher

final class DragonDetailsView: BaseView {
    let dragonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let greetingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("greet".localized, for: .normal)
        return button
    }()
    
    override func initialize() {
        backgroundColor = .white
        addSubview(dragonImageView)
        addSubview(descriptionLabel)
        addSubview(ageLabel)
        addSubview(greetingButton)
    }
    
    override func setupConstraints() {
        setupDragonImageViewConstraints()
        setupDescriptionLabel()
        setupAgeLabel()
        setupGreetingButton()
    }
    
    private func setupDragonImageViewConstraints() {
        dragonImageView.snp.makeConstraints {
            let topConstraint = AppDelegate.isIphoneXOrBigger ? 140 : 110
            $0.top.equalToSuperview().inset(topConstraint)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(dragonImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(7)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setupAgeLabel() {
        ageLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(7)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func setupGreetingButton() {
        greetingButton.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(7)
            $0.trailing.equalToSuperview().inset(7)
            $0.height.equalTo(40)
        }
    }
}
