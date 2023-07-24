//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation

public struct Organization: Decodable, Hashable {
    public var login: String
    public var id: Int
    public var node_id: String
    public var url: String
    public var repos_url: String
    public var events_url: String
    public var hooks_url: String
    public var issues_url: String
    public var members_url: String
    public var public_members_url: String
    public var avatar_url: String
    public var description: String?
}
