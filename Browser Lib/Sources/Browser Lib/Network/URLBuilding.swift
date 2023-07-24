//
//  URLBuilding.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

protocol URLBuilding {
    func makeURL() -> URL?
}

protocol HeaderBuilding {
    func makeHeader(session: UserSession) -> [String: String]
}

struct URLBuilder {
    struct Organizations: API, URLBuilding {
        func makeURL() -> URL? {
            let result = apiURL(Settings.GITHub.schema,
                                baseHost: Settings.GITHub.baseHost,
                                path: "/" + Settings.GITHub.Organizations.path,
                                queryItems: nil)
            return result
        }
    }
    struct URLBuilder: API, URLBuilding {
        var urlString: String

        func makeURL() -> URL? {
            URL(string: urlString)
        }
    }
}

struct HeaderBuilder: HeaderBuilding {
    //Query parameters
    // since
    // per_page

    func makeHeader(session: UserSession) -> [String: String] {
        guard let token = session.token, token.isEmpty == false else { return [:] }
        return [
            Settings.GITHub.Header.acceptKey: Settings.GITHub.Header.acceptValue,
            Settings.GITHub.Header.apiVersionKey: Settings.GITHub.Header.apiVersion,
            Settings.GITHub.Header.authorizationKey: Settings.GITHub.Header.authorization(bearer: token)
        ]
    }
}

//curl -L \
//  -H "Accept: application/vnd.github+json" \
//  -H "Authorization: Bearer <YOUR-TOKEN>" \
//  -H "X-GitHub-Api-Version: 2022-11-28" \
//  https://api.github.com/organizations
