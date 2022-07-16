//
//  SignUpView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import NavigationStack

struct SignUpView: View {
    //MARK: Properties
    @StateObject private var viewModel = SignUpViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack
    
    //MARK: Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 1){
                HStack{
                    Button {
                        self.navigationStack.pop()
                    } label: {
                        Image("LeftArrow").colorMultiply(.black)
                    }
                    Spacer()
                }
                .padding(.leading, 30)
                
                Text("Welcome,")
                    .font(.custom("Poppins", size: 22 ))
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                    .padding(.leading, 30)
                Text("Register to get started!")
                    .font(.custom("Poppins", size: 15 ))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.leading, 30)
                MaterialTextField(hint: "Email", text: $viewModel.email, status: viewModel.emailStatus, errorMsg: "", isSecure: false)
                    .padding(.top, 20)
                    .padding(.bottom, -10)
                MaterialTextField(hint: "Password", text: $viewModel.password, status: viewModel.emailStatus, errorMsg: "", isSecure: true)
                    .padding(.top, 0)
                MaterialTextField(hint: "Confirm Password", text: $viewModel.confirmPassword, status: viewModel.emailStatus, errorMsg: viewModel.errorMsg, isSecure: true)
                    .padding(.top, 0)
                Button {
                    registerUser()
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
}

//MARK: Preview
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

//MARK: Functions
extension SignUpView{
    fileprivate func registerUser(){
        viewModel.registerUser { status, msg in
            if status{
                self.navigationStack.push(HomeView())
            }else{
                viewModel.errorMsg = msg ?? "Something went wrong"
                viewModel.emailStatus = .danger
            }
        }
    }
}
