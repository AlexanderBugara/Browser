//
//  ContainerNetworkLoadingState.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit
import Browser_Lib

struct ContainerNetworkLoadingState: ContainerStateable, Sender {
    private(set) var layout: Layouting
    private(set) var content: UIViewController
    private var client: BrowserLibClient

    init(layout: Layouting = LoadingLayout(),
         content: UIViewController = LoadingViewController(message: .loadingData),
         client: BrowserLibClient) {
        self.layout = layout
        self.content = content
        self.client = client
    }

    func update(context: ContainerStateContextProtocol & UIViewController) {
        _ = client.organization.fetch(sender: self) { result in
            switch result {
            case .success(let dataSet):
                context.state = ContainerContentState(dataSet: dataSet, client: client)
            case .failure(let error):
                context.state = ContainerErrorState(client: client, error: error)
            }
        }
    }

    func notify(networkStatus: Browser_Lib.NetworkStatus) {

    }
}
