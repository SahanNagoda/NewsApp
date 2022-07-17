//
//  LoginView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import NavigationStack

struct LoginView: View {
    //MARK: Properties
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack
    
    //MARK: Body
    var body: some View {
        VStack(alignment: .leading, spacing: 1){
            Image("logo")
                .resizable()
                .frame(width: 200, height: 80)
                .padding(.top, 10)
                .padding(.leading, 10)
            
            Text("Welcome back,")
                .font(.custom("Poppins", size: 22 ))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.leading, 30)
            Text("Login to get started!")
                .font(.custom("Poppins", size: 15 ))
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .padding(.leading, 30)
            MaterialTextField(hint: "Email", text: $viewModel.email, status: viewModel.emailStatus, errorMsg: "", isSecure: false)
                .padding(.top, 20)
                .padding(.bottom, -10)
            MaterialTextField(hint: "Password", text: $viewModel.password, status: viewModel.emailStatus, errorMsg: viewModel.errorMsg, isSecure: true)
                .padding(.top, 0)
            Button {
                loginUser()
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
            //MARK: Footer
            HStack(spacing: 50){
                Text("Don’t have an account?")
                    .font(.custom("Poppins", size: 14 ))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Button {
                    DispatchQueue.main.async {
                        self.navigationStack.push(SignUpView())
                    }
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
            .padding(.bottom, 10)
            .background(Rectangle()
                .fill(Color.LightBackground)
                .ignoresSafeArea())
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//MARK: Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
        
    }
}

//MARK: Functions
extension LoginView{
    /// Authenticate the User
    fileprivate func loginUser(){
        viewModel.loginUser { status, msg in
            if status{
                self.navigationStack.push(HomeView())
            }else{
                viewModel.errorMsg = msg ?? "Something went wrong"
                viewModel.emailStatus = .danger
            }
        }
    }
}
