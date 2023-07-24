//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

public enum AppError {
    case httpError(HTTPStatusCode)
    case nilURL
    case nilRequest
    case nilData
    case serverError(code: Int, message: String)
    case connectionError(String)
    case decodingError(String)
    case undefined
    case locationServiceIsDisabled
    case locationError(Error)
}

extension AppError: CustomNSError {
    public var errorUserInfo: [String : Any] {
        return [NSLocalizedDescriptionKey: self.errorDescription()]
    }

    private func errorDescription() -> String {
        switch self {
        case .httpError(let statusCode): return "\(statusCode.rawValue), \(statusCode.description)"
        case .nilURL: return "Error: URL could not be build"
        case .serverError(let code, let message): return "Error code: \(code) message: \(message)"
        case .connectionError(let errorLocalizationDescription): return "Connection error: \(errorLocalizationDescription)"
        case .decodingError(let errorLocalizationDescription): return "Decodable error: \(errorLocalizationDescription)"
        case .nilData: return "Server return: data is empty"
        case .undefined: return "Error: undefined"
        case .locationServiceIsDisabled: return "You can select your city by name or Go to Settings > Privacy & Security > Location Services amd turn on location service"
        case .locationError(let error): return "Location manager error: \(error.localizedDescription)"
        case .nilRequest: return "Network request can't be created"
        }
    }
}
