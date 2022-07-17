//
//  SplashScreenView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI
import NavigationStack

struct SplashScreenView: View {
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        VStack{
            LottieView(lottieFile: "splash-screen-animation")
                .frame(width: 300, height: 300)
                .padding(.bottom, 0)
                .padding(.top, 0)
            Image("logo")
                .resizable()
                .frame(width: 200, height: 80)

        }.onAppear{
            let isLoggedIn = DataStore.shared.isLogged()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if isLoggedIn {
                    self.navigationStack.push(HomeView())
                }else{
                    self.navigationStack.push(LoginView())
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
