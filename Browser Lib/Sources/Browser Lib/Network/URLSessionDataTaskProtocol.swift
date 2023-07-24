//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

protocol URLSessionDataTaskProtocol: Cancallable {
    var state: URLSessionTask.State { get }
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
