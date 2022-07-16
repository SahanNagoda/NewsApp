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
struct Article: Codable, Hashable {
    var id = UUID().uuidString
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let content: String?
    

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case content = "content"
    }
}



typealias Articles = [Article]
