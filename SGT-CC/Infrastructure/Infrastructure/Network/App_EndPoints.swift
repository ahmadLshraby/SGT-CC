//
//  App_EndPoints.swift
//  Infrastructure
//
//  Created by AhmadShraby on 6/21/24.
//

import Foundation
import Core

enum App_EndPoints {
    
    enum Movies: EndPoint {
        case getPopularMovies(page: Int)
        case getMovieDetails(id: Int)
        
        var path: String {
            let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? "Not found"
            switch self {
            case .getPopularMovies(let page):
                    return "\(baseURL)movie/now_playing?language=en-US&page=\(page)"
            case .getMovieDetails(let id):
                return "\(baseURL)movie/\(id)?language=en-US"
            }
        }
        
        var method: NetworkRequestMethod {
            switch self {
            default:
                return .get
            }
        }
        
        var headers: [String : Any]? {
            let token = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String ?? "Not found"
            switch self {
            default:
                return ["Authorization": "Bearer \(token)"]
            }
        }
        
        var parameters: [String : Any]? {
            switch self {
            default:
                return nil
            }
        }
    }
    
}
