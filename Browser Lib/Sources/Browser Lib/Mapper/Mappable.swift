//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import CoreData

public protocol Mappable {
    associatedtype M: NSManagedObject
    associatedtype D: Decodable
    var managingType: M.Type { get }
    var dtoType: D.Type { get }
    var dto: D { get }
    var manageObject: M? { get }
    func setup(managed: NSManagedObject)
}
