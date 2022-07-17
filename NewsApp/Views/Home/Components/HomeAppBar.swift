//
//  HomeAppBar.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI
import NavigationStack

struct HomeAppBar: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
        HStack(spacing: 0){
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.LightGrey, lineWidth: 1)
                    .frame(width: .infinity, height: 32, alignment: .leading)
                
                HStack {
                    Text("Search")
                        .font(.custom("Poppins", size: 12 ))
                        .foregroundColor(  .DarkGrey)
                        .keyboardType(.webSearch)
                        .frame(width: .infinity)
                        .padding(.leading, 16)
                    Spacer()
                    Image("Search")
                    
                        .padding(.trailing, 16)
                }
            }.onTapGesture {
                self.navigationStack.push(SearchView())
            }
            Button {
                DataStore.shared.loggedOut()
                self.navigationStack.push(LoginView())
            } label: {
                ZStack{
                    Circle()
                        .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 32, height: 32)
                    Image("logout")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.leading, 16)
        }.padding(15)
    }
}

