//
//  Generic.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation
enum NAStatus: String, Codable {
    case error
    case ok
}

struct NAGeneric: Codable {
    let status: NAStatus
    let message: String?
    let code: String?
}

struct NAResponse<T: Codable>: Codable {
    let status: NAStatus
    let message: String?
    let code: String?
    let articles: T?
    let totalResults: Int?
}
