//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation

public struct OrganizationMapper: Mapper {
    public typealias T = OrganizationManagedObject
    public typealias D = Organization

    public func map(managed: T, dto: D) {
        managed.login = dto.login
        managed.id = Int16(dto.id)
        managed.node_id = dto.node_id
        managed.url = dto.url
        managed.repos_url = dto.repos_url
        managed.events_url = dto.events_url
        managed.hooks_url = dto.hooks_url
        managed.issues_url = dto.hooks_url
        managed.members_url = dto.members_url
        managed.public_members_url = dto.public_members_url
        managed.avatar_url = dto.avatar_url
        managed.descr = dto.description
    }
}
