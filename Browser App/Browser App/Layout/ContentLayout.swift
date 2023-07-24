//
//  ContentLayout.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

struct ContentLayout: Layouting {
    weak var container: UIView?
    weak var content: UIView?

    func layout() {
        guard let container = container, let content = content else { return }
        content.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            content.topAnchor.constraint(equalTo: container.topAnchor, constant: container.safeAreaInsets.top),
            content.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
