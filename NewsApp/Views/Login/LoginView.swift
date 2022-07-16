//
//  LoginView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import NavigationStack

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var inputTextField: Bool
    @State private var isNextNavigationActive: Bool = false
    @State private var isSignUpNavigationActive: Bool = false
    @State private var errorMsg: String = ""
    var body: some View {
        
            
            VStack(alignment: .leading, spacing: 1){

                Text("K-News")
                    .font(.custom("Poppins", size: 35 ))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 66)
                    .padding(.leading, 30)

                Text("Welcome back,")
                    .font(.custom("Poppins", size: 22 ))
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                    .padding(.leading, 30)
                Text("Login to get started!")
                    .font(.custom("Poppins", size: 15 ))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.leading, 30)
                MaterialTextField(hint: "Email", text: $viewModel.email, status: viewModel.emailStatus, errorMsg: errorMsg)
                    .padding(.top, 20)
                    .padding(.bottom, -10)
                MaterialTextField(hint: "Password", text: $viewModel.email, status: viewModel.emailStatus, errorMsg: errorMsg)
                    .padding(.top, 0)
                //TODO: Add Email and Password
                Text(errorMsg)
                    .font(.custom("Poppins", size: 12 ))
                    .foregroundColor(Color("Red"))
                    .frame(maxWidth: .infinity,  alignment: .leading)
                    .padding(.horizontal, 30.0)
                
                Button {
                    loginWithMobileNo()
                } label: {
                    Rectangle()
                        .fill( .black)
                        .overlay(
                            HStack {
                                Text("Continue")
                                    .font(.custom("Poppins", size: 14))
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white  )
                                Image("WhiteRightArrow")
                                    .colorMultiply( .white  )
                            }
                        )
                    
                        .frame(width: 150, height: 45)
                        .cornerRadius(5)
                        .padding(.leading,30)
                        .frame(height: 50)
                        .cornerRadius(5)
                    
                    
                }
                .padding(.top, 10)
                
                Spacer()
                HStack(spacing: 50){
                    Text("Don’t have an account?")
                        .font(.custom("Poppins", size: 14 ))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Button {
                        isSignUpNavigationActive = true
                    } label: {
                        Rectangle()
                            .fill(.black)
                            .overlay(
                                HStack {
                                    Text("Sign Up")
                                        .font(.custom("Poppins", size: 14))
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color.white)
                                    Image("WhiteRightArrow")
                                }
                            )
                            .frame(height: 50)
                            .cornerRadius(5)
                        
                    }
                }
                .padding(.all, 20)
                .background(Rectangle()
                    .fill(.gray.opacity(0.5))
                    .ignoresSafeArea())
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
           
    }
}


extension LoginView{
    fileprivate func loginWithMobileNo(){
        
    }
}
