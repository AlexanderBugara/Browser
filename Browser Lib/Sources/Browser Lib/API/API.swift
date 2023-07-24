//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

protocol API {
    func apiURL(_ schema: String, baseHost: String, path: String?, queryItems: [URLQueryItem]?) -> URL?
}

extension API {
    private func apiComponents(_ schema: String, baseHost: String, path: String, queryItems: [URLQueryItem]?) -> URLComponents {
        var components = URLComponents()
        components.scheme       = schema
        components.host         = baseHost
        components.path         = path
        components.queryItems   = queryItems
        return components
    }

    func apiURL(_ schema: String, baseHost: String, path: String?, queryItems: [URLQueryItem]?) -> URL? {
        guard let path = path, path.isEmpty == false
            else { return nil }
        return apiComponents(schema, baseHost: baseHost, path: path, queryItems: queryItems).url
    }

    func makeURLQueryItem(key: String, value: String) -> URLQueryItem {
        URLQueryItem(name: key, value: value)
    }
}
