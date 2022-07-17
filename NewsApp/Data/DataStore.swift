//
//  DataStore.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation
import RealmSwift

class DataStore{
    static let shared  = DataStore()
    private let localRealm = try! Realm()
    private init(){}
    
    /// Able to register new User
    /// - Parameters:
    ///   - email: Email
    ///   - password: Password
    func registerUser(email: String, password: String){
        let user = User(email: email.lowercased(), password: password, isLoggedIn: true)
        try! localRealm.write {
            localRealm.add(user)
        }
    }
    
    /// Able to get current logged in user
    /// - Returns: Current User
    func getCurrentUser() -> User?{
        let users = localRealm.objects(User.self)
        return users.first { user in
            return user.isLoggedIn
        }
    }
    
    /// Able to verify user email and password
    /// - Parameters:
    ///   - email: Email
    ///   - password: Password
    /// - Returns: Return true if user is verified
    func logInUser(email: String, password: String) -> Bool{
        let users = localRealm.objects(User.self)
        let user = users.first { user in
            return (user.email == email.lowercased()) && (user.password == password)
        }
        guard let user = user else { return false }
        try! localRealm.write {
            user.isLoggedIn = true
        }
        return true
    }
    
    /// Able to logout every user
    func logoutUser(){
        let users = localRealm.objects(User.self)
        users.forEach { user in
            try! localRealm.write {
                user.isLoggedIn = false
            }
        }
    }
    
    /// Able to check user is Logged in
    /// - Returns: Return true if user already logged
    func isLogged() -> Bool{
        guard getCurrentUser() != nil else { return false }
        return true
    }
    
    /// Able to save user is logout successfully
    func loggedOut() {
        logoutUser()
    }
    
}
