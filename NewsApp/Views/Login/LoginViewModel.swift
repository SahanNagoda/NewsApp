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
}
