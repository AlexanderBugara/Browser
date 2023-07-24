//
//  LoadingLayout.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

struct LoadingLayout: Layouting {
    weak var container: UIView?
    weak var content: UIView?

    func layout() {
        guard let container = container, let content = content else { return }
        content.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            content.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            content.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            content.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            content.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            content.topAnchor.constraint(lessThanOrEqualTo: container.topAnchor, constant: 20),
            content.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

