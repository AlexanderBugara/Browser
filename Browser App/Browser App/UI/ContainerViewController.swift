//
//  ContainerViewController.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit

final class ContainerViewController: UIViewController {
    private var layout: Layouting?
    private let initState: ContainerStateable
    private weak var content: UIViewController?

    var state: ContainerStateable? {
        didSet {
            guard let state = state else { return }
            remove(viewController: content)
            layout = state.layout
            state.update(context: self)
            add(state.content)

            let navigationItemState = state as? NavigationButtonsProtocol
            navigationItem.leftBarButtonItem = navigationItemState?.leftButton
            navigationItem.rightBarButtonItem = navigationItemState?.rightButton
        }
    }

    init(initState: ContainerStateable) {
        self.initState = initState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        state = initState
    }

    
}

extension ContainerViewController: ContainerStateContextProtocol {
    func add(_ content: UIViewController) {
        guard self.content == nil else { return }
        addChild(content)
        view.addSubview(content.view)
        content.didMove(toParent: self)
        layout?.addContainer(self.view)
        layout?.addContent(content.view)
        layout?.layout()
        self.content = content
    }

    func remove(viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        self.content = nil
    }
}
