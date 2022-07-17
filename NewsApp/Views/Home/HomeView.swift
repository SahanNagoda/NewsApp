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
    
    //MARK: Body
    var body: some View {
        VStack {
            //MARK: APP BAR
            HomeAppBar()
            ScrollView{
                //MARK: LATEST NEWS TITLE
                HStack {
                    Text("Latest News")
                        .font(.custom("Nunito", size: 18 ))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button {
                        self.navigationStack.push(AllNewsView())
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
                
                //MARK: LATEST CAROUSEL
                if viewModel.latestArticles.count > 0 {
                    ACarousel(viewModel.latestArticles, id: \.self,
                              spacing: 10,
                              headspace: 20,
                              sidesScaling: 0.9,
                              isWrap: true,
                              autoScroll: .active(10)) { item in
                        CarouselCard(item: item)
                    }
                    .frame(height: 240)
                }else{
                    ProgressView()
                        .frame(height: 240)
                }
                
                //MARK: CATEGORIES
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        ForEach(viewModel.categories, id: \.self) { item in
                            let isSelected = (item == viewModel.selectedCategory)
                            Button {
                                viewModel.selectedCategory = item
                                viewModel.categoryArticles = []
                                getLatestNewsByCategory()
                            } label: {
                                CategoryButton(isSelected: isSelected, item: item)
                            }
                        }
                    }
                    .padding(.top, 25)
                    .padding(.bottom, 10)
                    .padding(.leading, 15)
                    .frame( height: 50)
                }
                
                //MARK: CATEGORIES ARTICLES
                if viewModel.categoryArticles.count > 0 {
                    VStack {
                        ForEach(viewModel.categoryArticles, id: \.self) { item in
                            NewsCard(item: item)
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 16)
                }else{
                    ProgressView()
                        .padding(50)
                }
                
                
            }
            .refreshable {
                refresh()
            }
        }.onAppear{
            getLatestNews()
            getLatestNewsByCategory()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//MARK: Functions
extension HomeView{
    /// Able to reload the data
    fileprivate func refresh(){
        viewModel.latestArticles = []
        viewModel.categoryArticles = []
        getLatestNews()
        getLatestNewsByCategory()
    }
    /// Able to get Latest news
    fileprivate func getLatestNews(){
        if viewModel.latestNewsIsBusy{
            return
        }
        viewModel.latestNewsIsBusy = true
        viewModel.getLatestNews { status, msg in
            viewModel.latestNewsIsBusy = false
            if !status{
                //TODO: Add Error Alert
            }
        }
    }
    
    /// Able to get latest news by category
    fileprivate func getLatestNewsByCategory(){
        if viewModel.newsCategoryIsBusy{
            return
        }
        viewModel.newsCategoryIsBusy = true
        viewModel.getLatestNewsByCategory { status, msg in
            viewModel.newsCategoryIsBusy = false
            if !status{
                //TODO: Add Error Alert
            }
        }
    }
}





