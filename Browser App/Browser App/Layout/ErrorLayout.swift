//
//  ErrorLayout.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

struct ErrorLayout: Layouting {
    weak var container: UIView?
    weak var content: UIView?

    func layout() {
        guard let container = container, let content = content else { return }
        content.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            content.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            content.topAnchor.constraint(equalTo: container.topAnchor,
                                         constant: container.safeAreaInsets.top),
            content.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            content.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
