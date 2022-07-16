//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import Moya
import Combine
class LoginViewModel: ObservableObject{
    @Published var email: String = "" {
        didSet{
            if email.isValidEmail()  {
                validEmail = true
            }else{
                validEmail = false
            }
        }
    }
    @Published var password: String = ""
    @Published var emailStatus: TextFieldStatus = .idel
    @Published var validEmail: Bool = false
    @Published var errorMsg: String = ""
    
    func loginUser(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        if !validEmail {
            return completion(false, "Email is not valid")
        }else if password.isEmpty{
            return completion(false, "Password can not be empty")
        }
        
        let isEmailAuthenticated = DataStore.shared.checkEmail(email: email)
        let isPasswordAuthenticated = DataStore.shared.checkPassword(password: password)
        if isEmailAuthenticated && isPasswordAuthenticated{
            completion(true, nil)
        }else{
            completion(false, "You have entered an invalid username or password")
        }
        
    }
}
