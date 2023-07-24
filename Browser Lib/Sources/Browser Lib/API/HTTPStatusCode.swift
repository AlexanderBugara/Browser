//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

public enum HTTPStatusCode: Int {
    case OK = 200
    case notModified = 304
    case undefinedStatus
    case undefined
    case notFound = 404
}

extension HTTPStatusCode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .OK: return "OK"
        case .notModified: return "Not modified"
        case .undefinedStatus: return "Undefined network error"
        case .undefined: return "Undefined error"
        case .notFound: return "Resource not found"
        }
    }

    init(httpResponse: HTTPURLResponse) {
        self = HTTPStatusCode(rawValue: httpResponse.statusCode) ?? .undefined
    }

    public var isInformational: Bool {
        return isIn(range: 100...199)
    }

    public var isSuccess: Bool {
        return isIn(range: 200...299)
    }

    public var isRedirection: Bool {
        return isIn(range: 300...399)
    }

    public var isClientError: Bool {
        return isIn(range: 400...499)
    }

    public var isServerError: Bool {
        return isIn(range: 500...599)
    }

    private func isIn(range: ClosedRange<HTTPStatusCode.RawValue>) -> Bool {
        return range.contains(rawValue)
    }
}
