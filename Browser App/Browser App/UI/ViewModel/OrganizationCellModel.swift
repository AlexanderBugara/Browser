//
//  OrganizationCellModel.swift
//  Browser App
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation
import Browser_Lib

struct OrganizationCellModel: CollectionViewElement {
    var id: String = UUID().description
    let dto: Organization
    let presenting: Presenting = OrganizationCell.self
    let isFavorite: Bool

    var login: String {
        dto.login
    }

    init(dto: Organization, isFavorite: Bool) {
        self.dto = dto
        self.isFavorite = isFavorite
    }
}

extension OrganizationCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(dto.id)
    }
}

extension OrganizationCellModel: Equatable {
    static func == (lhs: OrganizationCellModel, rhs: OrganizationCellModel) -> Bool {
        lhs.dto.id == rhs.dto.id
    }
}
