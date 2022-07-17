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
    
    func setPassword(password: String) {
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    fileprivate func getPassword() -> String? {
        return UserDefaults.standard.string(forKey: "password")
    }
    
    func setEmail(email: String) {
        UserDefaults.standard.set(email.lowercased(), forKey: "email")
    }
    
    func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: "email")
    }
    
    func isLogged() -> Bool{
        return UserDefaults.standard.bool(forKey: "isLogged")
    }
    
    func loggedIn() {
        UserDefaults.standard.set(true, forKey: "isLogged")
    }
    
    func loggedOut() {
        UserDefaults.standard.set(true, forKey: "isLogged")
    }
    
    func checkEmail(email: String) -> Bool{
        guard let storeEmail = getEmail() else { return false }
        if email.lowercased() == storeEmail{
            return true
        }
        return false
    }
    
    func checkPassword(password: String) -> Bool{
        guard let pass = getPassword() else { return false }
        if password == pass{
            return true
        }
        return false
    }
    
}
