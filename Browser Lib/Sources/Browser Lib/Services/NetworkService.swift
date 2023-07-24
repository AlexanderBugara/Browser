//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

struct URLRequestComposer {
    var urlBuilder: URLBuilding
    var headerBuilder: HeaderBuilding
    var session: UserSession

    func makeRequest() -> URLRequest? {

        guard let url = urlBuilder.makeURL() else { return nil }

        // https://api.github.com/organizations

        var request = URLRequest(url: url)
        let headerValues = headerBuilder.makeHeader(session: session)
        headerValues.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        // print(request.allHTTPHeaderFields)
        return request
    }
}


final class NetworkService: Networking {
    var urlSession: URLSessionProtocol

    init(urlsSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlsSession
    }

    func dataTask(requestComposer: URLRequestComposer, completion: @escaping (Result<Data, AppError>) -> Void) -> URLSessionDataTaskProtocol? {

        guard let request = requestComposer.makeRequest() else {
            completion(.failure(.nilRequest))
            return nil
        }

        let dataTask = urlSession.dataTask(with: request) { data, urlResponse, _ in
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                completion(.failure(.serverError(code: 0, message: "Server Response Invalid")))
                return
            }

            let httpStatusCode = HTTPStatusCode(httpResponse: httpResponse)

            guard httpStatusCode.isSuccess else {
                completion(.failure(.httpError(httpStatusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.nilData))
                return
            }

            completion(.success(data))
        }

        return dataTask
    }

}
