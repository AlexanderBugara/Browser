//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation

public protocol Filterable {
    var isExclude: Bool { get }
}

public protocol DataSet {
    var organizations: [Organization] { get }
    func filter(value: String)
    func reset()
}

public protocol OrganizationsProviding {
    var organizations: [MapOrganization] { get }
    func set(image: Data?, organization: Organization)
    func getImage(by: Organization) -> Data?
    func filter(value: String)
    func reset()
}

public struct OrganizationsFilter {
    var value: String

    mutating func update(value: String) {
        self.value = value
    }

    func execute(input: [MapOrganization]) -> [MapOrganization] {
        guard !value.isEmpty else { return input }
        return input.filter {  $0.dto.login.contains(value) }
    }
}

public final class OrganizationsDataSet: OrganizationsProviding {
    private var filter: OrganizationsFilter
    private var _organizations: [MapOrganization] = []
    private var images: [Organization: Data] = [:]
    public var organizations: [MapOrganization] {
        filter.execute(input: _organizations)
    }
    public func add(organizations: [MapOrganization]) {
        _organizations.append(contentsOf: organizations)
    }
    public func filter(value: String) {
        filter.update(value: value)
    }
    public func reset() {
        _organizations.removeAll()
        images.removeAll()
    }
    init(filter: OrganizationsFilter) {
        self.filter = filter
    }
    public func set(image: Data?, organization: Organization) {
        images[organization] = image
    }
    public func getImage(by: Organization) -> Data? {
        images[by]
    }
}
