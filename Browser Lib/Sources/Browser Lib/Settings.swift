//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

struct Settings {
    struct GITHub {
        struct Header {
            static let acceptKey        = "Accept"
            static let acceptValue      = "application/vnd.github+json"
            static let authorizationKey = "Authorization"
            static let apiVersionKey    = "X-GitHub-Api-Version"
            static let apiVersion       = "2022-11-28"
            static func authorization(bearer: String) -> String { "Bearer \(bearer)" }
        }
        static var schema        = "https"
        static var baseHost      = "api.github.com"
        struct Organizations {
            static let path      = "organizations"
        }
    }
}
