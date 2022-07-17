//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import NavigationStack
@main
struct NewsAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStackView {
                SplashScreenView()
                    
            }.preferredColorScheme(.light)
        }
    }
}
