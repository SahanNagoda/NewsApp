//
//  User.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var email: String = ""
    @Persisted var password: String = ""
    @Persisted var isLoggedIn: Bool = false
    convenience init(email: String, password: String, isLoggedIn: Bool) {
        self.init()
        self.email = email
        self.password = password
        self.isLoggedIn = isLoggedIn
    }
}

