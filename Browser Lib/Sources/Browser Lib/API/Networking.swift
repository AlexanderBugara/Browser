//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

protocol Networking {
    func dataTask(requestComposer: URLRequestComposer, completion: @escaping (Result<Data, AppError>) -> Void) -> URLSessionDataTaskProtocol?
}
