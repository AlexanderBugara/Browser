//
//  ErrorViewController.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit
import Browser_Lib

final class ErrorViewController: UIViewController {
    private let messageLabel = UILabel()
    let error: AppError

    init(error: AppError) {
        self.error = error
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        messageLabel.text = error.localizedDescription
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
        messageLabel.textColor = .white
        view.backgroundColor = .red
    }

    private func setupConstraints() {
        let constraints = [
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

