//
//  Config.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation

public struct Config {
    struct API {
        enum STAGING {
            static let HOST = "https://newsapi.org/v2/"
            static let APIKEY = "e228d28e18d14dc9833911ef6abcabf5"
        }
        enum LIVE {
            static let HOST = "https://newsapi.org/v2/"
            static let APIKEY = "4e4660b25ada49318c3a14ab299092bc"
        }
    }
}
