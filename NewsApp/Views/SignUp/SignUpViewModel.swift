//
//  SignUpViewModel.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import Foundation

class SignUpViewModel: ObservableObject{
    @Published var email: String = "" {
        didSet{
            validateEmail()
        }
    }
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var emailStatus: TextFieldStatus = .idel
    @Published var validEmail: Bool = false
    @Published var errorMsg: String = ""
    
    fileprivate func validateEmail() {
        if email.isValidEmail()  {
            validEmail = true
        }else{
            validEmail = false
        }
    }
    
    /// Email and password will save locally if the email is valid and password are matched
    /// - Parameter completion: returns status and message
    func registerUser(completion: @escaping(_ status: Bool, _ message: String?) -> Void) {
        if !validEmail {
            return completion(false, "Email is not valid")
        }else if password != confirmPassword {
            return completion(false, "Password mismatched")
        }else if password.isEmpty || confirmPassword.isEmpty{
            return completion(false, "Password can not be empty")
        }
        
        DataStore.shared.registerUser(email: email, password: password)
        completion(true, nil)
    }
}
