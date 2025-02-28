//
//  HomeRootView.swift
//  NetworkingLayer
//
//  Created by Abiú Ramírez Roldán on 26/02/25.
//

import UIKit

final class HomeRootView: NiblessView {
    private let textLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Pokemon"
        textField.backgroundColor = .red
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.backgroundColor = .blue
        return stack
    }()

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.backgroundColor = .brown
        return stack
    }()
    
    var buttonTapped: (() -> Void)?

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        constructUI()
        setupLayouts()
        bindUI()
    }

    private func bindUI() {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.buttonTapped?()
        }
        searchButton.addAction(action, for: .primaryActionTriggered)
    }

    private func setupView() {
        backgroundColor = .black
    }

    private func constructUI() {
        addCustomSubviews([
            textLabel,
            searchButton
        ])
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            textLabel.heightAnchor.constraint(equalToConstant: 35),
            searchButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
            searchButton.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            searchButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }

    func getText() -> String? {
        textLabel.text
    }
}
