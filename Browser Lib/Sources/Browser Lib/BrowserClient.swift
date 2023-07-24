//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation
import CoreData
import UIKit

public protocol BrowserClientProtocol: AnyObject {

}

public protocol Cancallable {
    func cancel()
}


public enum NetworkStatus {
    case inProgress(BrowserLibAPI)
    case completed(BrowserLibAPI)
}

public protocol Sender {
    func notify(networkStatus: NetworkStatus)
}

public final class BrowserOrganization {
    private let session: UserSession
    private let server: Server
    private var organizationsDataSet = OrganizationsDataSet(filter: OrganizationsFilter(value: ""))
    private let persistentDataService: PersistentDataService

    private var favoritesDictionary = [Int16: OrganizationManagedObject]()

    init(session: UserSession,
         server: Server,
         persistentDataService: PersistentDataService = PersistentDataService()) {
        self.session = session
        self.server = server
        self.persistentDataService = persistentDataService
    }

    public func setup(completion: @escaping () -> Void) {
        persistentDataService.favorites { [unowned self] organizations in
            organizations.forEach { organization in
                self.favoritesDictionary[organization.id] = organization
            }
            completion()
        }
    }

    public func fetch(sender: Sender?, completion: @escaping (Result<OrganizationsProviding, AppError>) -> Void) -> Cancallable? {
        server.query(sender: sender,
                     api: .organizations,
                     session: session,
                     mapType: [Organization].self,
                     resultQueue: DispatchQueue.main) { [unowned self] result in
            switch result {
            case .success(let organizations):
                self.organizationsDataSet.add(organizations: organizations.map {
                    MapOrganization(dto: $0, mapper: OrganizationMapper())
                })
                completion(.success(self.organizationsDataSet))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    public func fetchAvatar(sender: Sender?,
                            dto: Organization,
                            resultQueue: DispatchQueue? = DispatchQueue.main,
                            completion: @escaping (Result<OrganizationsProviding, AppError>) -> Void) -> Cancallable? {
        let cancellable = server.fetchData(sender: sender,
                                           api: BrowserLibAPI.url(dto.avatar_url),
                                           session: session,
                                           resultQueue: resultQueue) { [unowned self] result in
            switch result {
            case .success(let data):
                self.organizationsDataSet.set(image: data, organization: dto)
                resultQueue?.async { completion(.success(self.organizationsDataSet)) }
            case .failure(let error):
                resultQueue?.async { completion(.failure(error)) }
            }
        }
        return cancellable
    }

    public func saveToFavorite(map: any Mappable) {
        guard let organization = persistentDataService.save(map: map) else { return }
        favoritesDictionary[organization.id] = organization
    }

    public func removeFromFavorite(id: Int16) {
        let organization = favoritesDictionary[id]
        persistentDataService.remove(object: organization)
        favoritesDictionary[id] = nil
    }

    public func favorites(completion: @escaping ([OrganizationManagedObject]) -> Void) {
        persistentDataService.favorites(completion: completion)
    }
    
    public func isOrganizationFavorite(id: Int16) -> Bool {
        favoritesDictionary[id] != nil
    }
}

public final class BrowserLibClient: BrowserClientProtocol {
    private let session: UserSession
    private let server: Server

    private(set) static var sharedClient: BrowserLibClient?


    public lazy var organization: BrowserOrganization = {
        BrowserOrganization(session: session, server: server)
    }()

    public static func shared(session: UserSession) -> BrowserLibClient {

        guard let sharedClient = sharedClient else {
            let sharedClient = BrowserLibClient(session: session)
            return sharedClient
        }

        return sharedClient
    }

    private init(session: UserSession,
                 server: Server = ServerTracker(server: BrowserLibServer())) {
        self.session = session
        self.server = server
    }


} 
