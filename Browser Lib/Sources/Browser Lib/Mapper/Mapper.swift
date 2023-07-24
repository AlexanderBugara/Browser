//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation
import CoreData

public protocol Mapper {
    associatedtype T: NSManagedObject
    associatedtype D: Decodable
    func map(managed: T, dto: D)
}
