//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation

final class ServerTracker: Server {
    private let server: Server

    init(server: Server) {
        self.server = server
    }

    func query<T>(sender: Sender?,
                  api: BrowserLibAPI,
                  session: UserSession,
                  mapType: T.Type,
                  resultQueue: DispatchQueue?,
                  completion: @escaping (Result<T, AppError>) -> Void) -> Cancallable? where T : Decodable {

        notify(sender: sender, networkStatus: .inProgress(api))

        return server.query(sender: sender,
                     api: api,
                     session: session,
                     mapType: mapType,
                     resultQueue: resultQueue) { [unowned self] result in
            self.notify(sender: sender, networkStatus: .completed(api))
            completion(result)
        }
    }

    func fetchData(sender: Sender?,
                   api: BrowserLibAPI,
                   session: UserSession,
                   resultQueue: DispatchQueue?,
                   completion: @escaping (Result<Data?, AppError>) -> Void) -> Cancallable? {

        notify(sender: sender, networkStatus: .inProgress(api))

        return server.fetchData(sender: sender,
                         api: api,
                         session: session,
                         resultQueue: resultQueue) { [unowned self] result in
            self.notify(sender: sender, networkStatus: .completed(api))
            completion(result)
        }
    }

    private func notify(sender: Sender?, networkStatus: NetworkStatus) {
        guard let sender = sender else { return }
        DispatchQueue.main.async {
            sender.notify(networkStatus: networkStatus)
        }
    }
}
