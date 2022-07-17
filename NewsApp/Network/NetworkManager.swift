//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation

enum APIEnvironment {
    case staging
    case live
    
    var baseURL: String {
        switch NetworkManager.environment {
        case .staging:
            return Config.API.STAGING.HOST
        case .live:
            return Config.API.LIVE.HOST
        }
    }
    
    var APIkey: String {
        switch NetworkManager.environment {
        case .staging:
            return Config.API.STAGING.APIKEY
        case .live:
            return Config.API.LIVE.APIKEY
        }
    }
}

struct NetworkManager {
    static let environment: APIEnvironment = .staging
}
