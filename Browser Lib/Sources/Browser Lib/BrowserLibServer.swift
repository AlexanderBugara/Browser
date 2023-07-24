//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation

protocol Server {
    func query<T: Decodable>(sender: Sender?,
                             api: BrowserLibAPI,
                             session: UserSession,
                             mapType: T.Type,
                             resultQueue: DispatchQueue?,
                             completion: @escaping (Result<T, AppError>) -> Void) -> Cancallable?

    func fetchData(sender: Sender?,
                   api: BrowserLibAPI,
                   session: UserSession,
                   resultQueue: DispatchQueue?,
                   completion: @escaping (Result<Data?, AppError>) -> Void) -> Cancallable?

}

public final class BrowserLibServer: Server {
    private let networkService: Networking

    init(networkService: Networking = NetworkService()) {
        self.networkService = networkService
    }

    func query<T: Decodable>(sender: Sender?,
                             api: BrowserLibAPI,
                             session: UserSession,
                             mapType: T.Type,
                             resultQueue: DispatchQueue? = DispatchQueue.main,
                             completion: @escaping (Result<T, AppError>) -> Void) -> Cancallable? {
        
        let composer = api.requestComposer(session: session)
        let decoder = DecodingService()
        let dataTask = networkService.dataTask(requestComposer: composer) { result in
            decoder.execute(result, mapType: T.self) { result in
                resultQueue?.async { completion(result) }
            }
        }
        dataTask?.resume()
        return dataTask
    }

    public func fetchData(sender: Sender?,
                          api: BrowserLibAPI,
                          session: UserSession,
                          resultQueue: DispatchQueue? = DispatchQueue.main,
                          completion: @escaping (Result<Data?, AppError>) -> Void) -> Cancallable? {
        let composer = api.requestComposer(session: session)
        let dataTask = networkService.dataTask(requestComposer: composer) { result in
            switch result {
            case .success(let data): resultQueue?.async { completion(.success(data)) }
            case .failure(let error): resultQueue?.async { completion(.failure(error)) }
            }
        }
        dataTask?.resume()
        return dataTask
    }
}
