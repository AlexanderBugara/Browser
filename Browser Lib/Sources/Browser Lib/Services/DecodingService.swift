//
//  File.swift
//  
//
//  Created by Oleksandr Buhara on 7/22/23.
//

import Foundation

protocol DecodingServicing {
    func execute<T>(_ input: Result<Data, AppError>, mapType: T.Type, completion: (Result<T, AppError>) -> Void) where T: Decodable
}

struct DecodingService: DecodingServicing {
    func execute<T>(_ input: Result<Data, AppError>, mapType: T.Type, completion: (Result<T, AppError>) -> Void) where T: Decodable {
        do {
            switch input {
            case .success(let data):
                let result: T = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }

        } catch {
            completion(.failure(AppError.decodingError(error.localizedDescription)))
        }
    }
}
