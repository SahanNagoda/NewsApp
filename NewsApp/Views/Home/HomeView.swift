//
//  HomeView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import NavigationStack
import ACarousel

struct HomeView: View {
    //MARK: Properties
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack
    @FocusState private var inputTextField: Bool
    let roles = ["Luffy", "Zoro", "Sanji", "Nami", "Usopp", "Chopper", "Robin", "Franky", "Brook"]
    //MARK: Body
    var body: some View {
        VStack {
            //APP BAR
            HStack(spacing: 0){
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.LightGrey, lineWidth: 1)
                        .frame(width: .infinity, height: 32, alignment: .leading)
                    
                    HStack {
                        TextField("Search", text: $viewModel.searchText)
                            .font(.custom("Poppins", size: 12 ))
                            .foregroundColor( viewModel.searchText.isEmpty ? .DarkGrey : .black)
                            .keyboardType(.webSearch)
                            .focused($inputTextField)
                            .frame(width: .infinity)
                            .padding(.leading, 16)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("Search")
                        }
                        .padding(.trailing, 16)
                        
                    }
                    
                }
                ZStack{
                    Circle()
                        .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 32, height: 32)
                    Image("Notification")
                }
                .padding(.leading, 16)
            }.padding(15)
            ScrollView{
                //LATEST NEWS TITLE
                HStack {
                    Text("Latest News")
                        .font(.custom("Nunito", size: 18 ))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("See All")
                            .font(.custom("Nunito", size: 12 ))
                            .fontWeight(.semibold)
                            .foregroundColor(.Secondary)
                            .multilineTextAlignment(.center)
                        Image("BlueRightArrow")
                            .frame(width: 9.85, height: 12)
                            .padding(.leading, 10)
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 15)
                
                //LATEST CAROUSEL
                ACarousel(roles, id: \.self,
                          spacing: 0,
                          headspace: 15,
                          sidesScaling: 0.97,
                          isWrap: false,
                          autoScroll: .active(10)) { item in
                    Text("Item \(item)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 350, height: 200)
                        .background(.red)
                }
                          .frame(height: 200)
                //CATEGORIES
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        ForEach(viewModel.categories, id: \.self) { item in
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                                Text(item)
                                    .font(.custom("Nunito", size: 18 ))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal,16)
                                    .padding(.vertical, 8)
                            }
                            
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 15)
                    
                }
                VStack {
                    ForEach(viewModel.categories, id: \.self) { item in
                        Text("Item \(item)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .background(.red)
                        
                    }
                }
                .padding(.top, 10)
                .padding(.horizontal, 16)
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
