//
//  APIContract.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation
import Combine

public protocol APIContract {
    func request<T: Codable>(endPoint: EndPoint, responseClass: T.Type) -> AnyPublisher<T, NetworkServicesError>
}
