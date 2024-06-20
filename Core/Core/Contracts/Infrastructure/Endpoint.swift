//
//  Endpoint.swift
//  Core
//
//  Created by AhmadShraby on 6/19/24.
//

import Foundation

public protocol EndPoint {
    var path: String { get }
    var method: NetworkRequestMethod { get }
    var headers: [String : Any]? { get }
    var parameters: [String : Any]? { get }
}
