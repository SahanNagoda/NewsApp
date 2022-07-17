//
//  DataStore.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation

class DataStore{
    static let shared  = DataStore()
    
    private init(){}
    
    /// Able to save password
    /// - Parameter password: password
    func setPassword(password: String) {
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    /// Able to extract password
    /// - Returns: User's password
    fileprivate func getPassword() -> String? {
        return UserDefaults.standard.string(forKey: "password")
    }
    
    /// Able to save password
    /// - Parameter email: User's Email
    func setEmail(email: String) {
        UserDefaults.standard.set(email.lowercased(), forKey: "email")
    }
    
    /// Able to get Email
    /// - Returns: Email
    func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: "email")
    }
    
    /// Able to check user is Logged in
    /// - Returns: Return true if user already logged
    func isLogged() -> Bool{
        return UserDefaults.standard.bool(forKey: "isLogged")
    }
    
    /// Able to save user is log successfully
    func loggedIn() {
        UserDefaults.standard.set(true, forKey: "isLogged")
    }
    
    /// Able to save user is logout successfully
    func loggedOut() {
        UserDefaults.standard.set(true, forKey: "isLogged")
    }
    
    /// Able to authenticate email
    /// - Parameter email: User entered email
    /// - Returns: Return true if emails are matched
    func checkEmail(email: String) -> Bool{
        guard let storeEmail = getEmail() else { return false }
        if email.lowercased() == storeEmail{
            return true
        }
        return false
    }
    
    /// Able to authenticate password
    /// - Parameter password: User entered password
    /// - Returns: Return true if passwords are matched
    func checkPassword(password: String) -> Bool{
        guard let pass = getPassword() else { return false }
        if password == pass{
            return true
        }
        return false
    }
    
}
