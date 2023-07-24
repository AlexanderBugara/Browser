//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/23/23.
//

import Foundation

public enum BrowserLibAPI {
    case organizations
    case url(String)

    func requestComposer(session: UserSession) -> URLRequestComposer {
        switch self {
        case .organizations:
            return URLRequestComposer(urlBuilder: URLBuilder.Organizations(),
                                      headerBuilder: HeaderBuilder(),
                                      session: session)
        case .url(let urlString):
            return URLRequestComposer(urlBuilder: URLBuilder.URLBuilder(urlString: urlString),
                                      headerBuilder: HeaderBuilder(),
                                      session: session)

        }
    }
}
