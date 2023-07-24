//
//  BrowserLibUserSession.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

public final class UserSession {
    var token: String?

    public init(token: String? = nil) {
        self.token = token
    }
}
