//
//  Generic.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation
enum CPStatus: String, Codable {
    case error
    case ok
}

struct CPGeneric: Codable {
    let status: CPStatus
    let message: String?
    let code: String?
}

struct CPResponse<T: Codable>: Codable {
    let status: CPStatus
    let message: String?
    let code: String?
    let articles: T?
    let totalResults: Int?
}
