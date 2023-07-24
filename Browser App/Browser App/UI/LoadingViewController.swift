//
//  LoadingViewController.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

enum Messages: String {
    case loadingData = "Loading data..."
    case decoding = "Data decoding process..."
}

final class LoadingViewController: UIViewController {

    let message: Messages
    private let messageLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    init(message: Messages) {
        self.message = message
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
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        view.addSubview(activityIndicator)
        messageLabel.text = message.rawValue
        messageLabel.textAlignment = .center
        activityIndicator.startAnimating()
    }

    private func setupConstraints() {
        let constraints = [
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: messageLabel.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

