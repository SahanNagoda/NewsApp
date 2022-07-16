//
//  ArticleAPI.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation
import Moya

enum ArticleAPI {
    case searchNews(keywords: String, page: Int,pageSize: Int)
    case searchNewsWithFilter(category: String, country: String, keywords: String, page: Int,pageSize: Int)
    case topHeadline(page: Int,pageSize: Int)
    case topHeadlineWithFilter(category: String, country: String, page: Int,pageSize: Int)
}

extension ArticleAPI: TargetType {
    var environment: APIEnvironment {
        NetworkManager.environment
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environment.baseURL) else { fatalError("base url not configured") }
        return url
    }
    
    public var apiKey: URL {
        guard let url = URL(string: environment.APIkey) else { fatalError("API Key not configured") }
        return url
    }
    
    var path: String {
        switch self {
        
        case .searchNews, .searchNewsWithFilter:
            return "top-headlines"
        case .topHeadline, .topHeadlineWithFilter:
            return "top-headlines"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        
            
        case .searchNews(keywords: let keywords, page: let page, pageSize: let pageSize):
            return .requestParameters(
                parameters: [ "page": page,
                              "pageSize": pageSize,
                              "q": keywords,
                              "apiKey": apiKey
                            ], encoding: URLEncoding.queryString)
        case .searchNewsWithFilter(category: let category, country: let country, keywords: let keywords, page: let page, pageSize: let pageSize):
                return .requestParameters(
                    parameters: [ "page": page,
                                  "pageSize": pageSize,
                                  "q": keywords,
                                  "category": category,
                                  "country": country,
                                  "apiKey": apiKey
                                ], encoding: URLEncoding.queryString)
        case .topHeadline(page: let page, pageSize: let pageSize):
            return .requestParameters(
                parameters: [ "page": page,
                              "pageSize": pageSize,
                              "apiKey": apiKey
                            ], encoding: URLEncoding.queryString)
        case .topHeadlineWithFilter(category: let category, country: let country, page: let page, pageSize: let pageSize):
            return .requestParameters(
                parameters: [ "page": page,
                              "pageSize": pageSize,
                              "category": category,
                              "country": country,
                              "apiKey": apiKey
                            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        
        let params = ["Content-Type": "application/json",
                      "Accept": "application/json"
        ]
        
        return params
        
    }
}
