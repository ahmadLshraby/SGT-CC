//
//  APIClient.swift
//  Infrastructure
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine
import Core

public final class APIClient: APIContract {
    
    // MARK: Initialization
    public init() { print("Initialization") }
    
    private var cancellables = Set<AnyCancellable>()
    
    public func request<T: Codable>(endPoint: EndPoint, responseClass: T.Type) -> AnyPublisher<T, NetworkServicesError> {
        
        // Print start message
        print("*****START*****\n",
              "PATH: \(endPoint.path)\n",
              "METHOD: \(endPoint.method.rawValue)\n",
              "PARAMETERS: \(endPoint.parameters ?? ["parameters": "NO"])\n",
              "HEADERS: \(endPoint.headers ?? ["headers": "NO"])\n")
        
        // Create URL request
        guard let url = URL(string: endPoint.path) else {
            return Fail(error: NetworkServicesError.unknownError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        
        if let headers = endPoint.headers {
            for (key, value) in headers {
                if let valueString = value as? String {
                    request.setValue(valueString, forHTTPHeaderField: key)
                }
            }
        }
        
        if let parameters = endPoint.parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                return Fail(error: NetworkServicesError.unknownError).eraseToAnyPublisher()
            }
        }
        
        // Use Combine to perform the request
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw NetworkServicesError.unknownError
                }
                
                switch httpResponse.statusCode {
                case 200, 201, 202:
                    return result.data
                case 401:
                    throw NetworkServicesError.authenticationError
                case 429:
                    // Handle response time limit
                    if let retryAfter = httpResponse.value(forHTTPHeaderField: "Retry-After") {
                        print("RETRY AFTER: \(retryAfter)")
                        throw NetworkServicesError.responseError(response: "Time limit error, Please retry after: \(retryAfter)")
                    } else {
                        throw NetworkServicesError.unknownError
                    }
                default:
                    throw NetworkServicesError.unknownError
                }
            }
            .mapError { error -> NetworkServicesError in
                if let networkError = error as? NetworkServicesError {
                    return networkError
                } else {
                    return NetworkServicesError.unknownError
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in NetworkServicesError.decodingError }
            .eraseToAnyPublisher()
    }
    
}
