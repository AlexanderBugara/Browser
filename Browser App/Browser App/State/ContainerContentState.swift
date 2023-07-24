//
//  ContainerContentState.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit
import Browser_Lib

final class ContainerContentState: NSObject, ContainerStateable {
    private weak var context: ContainerStateContextProtocol?
    lazy var content: UIViewController = {
        OrganizationsViewController(client: client, dataSet: dataSet)
    }()
    private(set) var layout: Layouting
    private let client: BrowserLibClient
    private var dataSet: OrganizationsProviding

    init(layout: Layouting = ContentLayout(),
         dataSet: OrganizationsProviding,
         client: BrowserLibClient) {
        self.layout = layout
        self.dataSet = dataSet
        self.client = client
    }

    func update(context: ContainerStateContextProtocol & UIViewController) {
        self.context = context
        let searchResult = OrganizationsViewController(client: client, dataSet: dataSet)
        let searchController = UISearchController(searchResultsController: searchResult)
        context.navigationItem.searchController = searchController
        context.navigationItem.searchController?.searchResultsUpdater = searchResult
    }
}
