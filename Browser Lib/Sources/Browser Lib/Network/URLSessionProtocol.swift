//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @Sendable @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
