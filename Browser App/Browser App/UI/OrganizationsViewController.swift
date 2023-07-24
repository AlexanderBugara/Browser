//
//  OrganizationsViewController.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit
import Browser_Lib

enum Section {
    case main
}

final class OrganizationsViewController: UICollectionViewController, UISearchResultsUpdating {
    private let client: BrowserLibClient
    private var dataSet: OrganizationsProviding
    private let reuseIdentifier = "cell"
   
    private var dataSource: UICollectionViewDiffableDataSource<Section, OrganizationCellModel>! = nil

    init(client: BrowserLibClient, dataSet: OrganizationsProviding) {
        self.client = client
        self.dataSet = dataSet
        let config = UICollectionLayoutListConfiguration(appearance: .sidebarPlain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        client.organization.setup { [unowned self] in
            self.configureDataSource()
        }
    }

    private func configureDataSource() {
        collectionView.register(OrganizationCell.self, forCellWithReuseIdentifier: "cell")
        dataSource = UICollectionViewDiffableDataSource<Section, OrganizationCellModel>(collectionView: collectionView) {
            [unowned self] collectionView, indexPath, item in

            let dto = item.dto
            let isFavorite = self.client.organization.isOrganizationFavorite(id: Int16(dto.id))
            let model = OrganizationCellModel(dto: dto, isFavorite: isFavorite)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                          for: indexPath) as? OrganizationCell
            cell?.setModel(model)
            _ = client.organization.fetchAvatar(sender: nil, dto: dto) { result in
                switch result {
                case .success(let dataProvider):
                    guard let imageData = dataProvider.getImage(by: dto) else { return }
                    cell?.setImage(image: UIImage(data: imageData))
                case .failure(_): break
                }
            }
            return cell
        }

        add(
            dataSet.organizations.map {
                let isFavorite = self.client.organization.isOrganizationFavorite(id: Int16($0.dto.id))
                return OrganizationCellModel(dto: $0.dto, isFavorite: isFavorite)
            }
        )
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let organization = dataSet.organizations[indexPath.row]

        let id = Int16(organization.dto.id)
        let isFavorite = self.client.organization.isOrganizationFavorite(id: id)
        if (isFavorite) {
            client.organization.removeFromFavorite(id: id)
        } else {
            client.organization.saveToFavorite(map: organization)
        }
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([OrganizationCellModel(dto: organization.dto, isFavorite: !isFavorite)])
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func add(_ models: [OrganizationCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, OrganizationCellModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(models, toSection: .main)
        snapshot.reloadItems(models)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        dataSet.filter(value: text)
        let models = dataSet.organizations.map {
            let isFavorite = self.client.organization.isOrganizationFavorite(id: Int16($0.dto.id))
            return OrganizationCellModel(dto: $0.dto, isFavorite: isFavorite)
        }
        add(models)
    }
}
