//
//  OrganizationCell.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import UIKit
import Browser_Lib

final class OrganizationCell: UICollectionViewCell, CellModeledView {
    typealias Model = OrganizationCellModel

    private let label = UILabel()
    private let favoritIndicator = UIView()
    private let avatar = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(avatar)
        contentView.addSubview(label)
        contentView.addSubview(favoritIndicator)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        favoritIndicator.translatesAutoresizingMaskIntoConstraints = false
        avatar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.heightAnchor.constraint(equalToConstant: 40),
            avatar.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            avatar.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: favoritIndicator.leadingAnchor, constant: -5),
            favoritIndicator.heightAnchor.constraint(equalToConstant: 10),
            favoritIndicator.widthAnchor.constraint(equalToConstant: 10),
            favoritIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            favoritIndicator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }

    func setModel(_ model: CollectionViewElement?) {
        guard let model = model as? Model else { return }
        label.text = model.login
        favoritIndicator.backgroundColor = model.isFavorite ? .yellow : .blue
    }

    func setImage(image: UIImage?) {
        avatar.image = image
    }
}

