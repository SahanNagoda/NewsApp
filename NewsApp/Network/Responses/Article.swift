//
//  Article.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let articles = try? newJSONDecoder().decode(Articles.self, from: jsonData)

import Foundation

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

typealias Articles = [Article]
