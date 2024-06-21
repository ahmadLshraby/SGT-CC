//
//  NetworkServicesError.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation

public enum NetworkServicesError: Error {
    case responseError(response: String)
    case validationError(validation: String)
    case authenticationError
    case connectionError
    case decodingError
    case unknownError
    
    public func get() -> String {
        switch self {
        case .responseError(let response):
            return response
        case .validationError(let validation):
            return validation
        case .authenticationError:
            return "You aren't authorized"
        case .connectionError:
            return "Please, Check Your Internet Connection"
        case .decodingError:
            return "Decoding error"
        case .unknownError:
            return "Something went wrong, please try again."
        }
    }
}
