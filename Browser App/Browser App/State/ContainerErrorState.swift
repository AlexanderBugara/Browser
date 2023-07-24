//
//  ContainerErrorState.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit
import Browser_Lib

final class ContainerErrorState: ContainerStateable, NavigationButtonsProtocol {
    var rightButton: UIBarButtonItem? = nil
    lazy var leftButton: UIBarButtonItem? = {
        UIBarButtonItem(title: "Refresh",
                        style: .plain,
                        target: self,
                        action: #selector(refresh))
    }()

    let error: AppError
    private weak var context: ContainerStateContextProtocol?
    private weak var errorViewController: ErrorViewController?
    private(set) var layout: Layouting
    private let client: BrowserLibClient
    private(set) lazy var content: UIViewController = {
        ErrorViewController(error: error)
    }()

    init(client: BrowserLibClient,
         layout: Layouting = ErrorLayout(),
         error: AppError) {
        self.client = client
        self.error = error
        self.layout = layout
    }

    func update(context: ContainerStateContextProtocol & UIViewController) {
        self.context = context
        let errorViewController = ErrorViewController(error: error)
        self.errorViewController = errorViewController
    }

    @objc func refresh() {
        self.context?.state = ContainerNetworkLoadingState(client: client)
    }
}
