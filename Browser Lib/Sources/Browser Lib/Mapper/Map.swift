//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation
import CoreData

public struct Map<M: NSManagedObject, D: Decodable, U: Mapper>: Mappable where U.T == M, U.D == D {
    public let managingType = M.self
    public let dtoType = D.self
    public let dto: D
    public var manageObject: M?
    private let mapper: U

    public func setup(managed: NSManagedObject) {
        guard let managed = managed as? M else { return }
        mapper.map(managed: managed, dto: dto)
    }
    public init(dto: D, manageObject: M? = nil, mapper: U) {
        self.dto = dto
        self.manageObject = manageObject
        self.mapper = mapper
    }
}
