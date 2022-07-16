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
    
    //MARK: Body
    var body: some View {
        VStack {
            //MARK: APP BAR
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
                            .focused($inputTextField)
                            .frame(width: .infinity)
                            .padding(.leading, 16)
                        Spacer()
                        Image("Search")
                            .padding(.trailing, 16)
                    }
                }.onTapGesture {
                    self.navigationStack.push(SearchView())
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
                //MARK: LATEST NEWS TITLE
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
                
                //MARK: LATEST CAROUSEL
                if viewModel.latestArticles.count > 0 {
                    ACarousel(viewModel.latestArticles, id: \.self,
                              spacing: 10,
                              headspace: 20,
                              sidesScaling: 0.9,
                              isWrap: true,
                              autoScroll: .active(10)) { item in
                        VStack(alignment:.leading){
                            Spacer()
                            if let author = item.author {
                                Text("by \(author)")
                                    .font(.custom("Nunito", size: 10 ))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            
                            Text("\(item.title)")
                                .font(.custom("Nunito", size: 18 ))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                            if let articleDescription = item.articleDescription {
                                Text("\(articleDescription)")
                                    .font(.custom("Nunito", size: 10 ))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 10)
                            }
                            
                        }.padding(16)
                            .frame(maxWidth: 340, minHeight: 240)
                            .background(
                                ZStack {
                                    AsyncImage(url: URL(string: item.urlToImage!), scale: 5) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .cornerRadius(8)
                                        
                                    } placeholder: {
                                        ProgressView()
                                            .progressViewStyle(.circular)
                                    }
                                    .frame(height: 240)
                                    LinearGradient(colors: [.black.opacity(0.1),.black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                                }
                            )
                            .cornerRadius(8)
                            .clipped()
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
                                ZStack{
                                    if isSelected {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    }else{
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.LightGrey, lineWidth: 1)
                                    }
                                    
                                    Text(item)
                                        .font(.custom("Nunito", size: 12 ))
                                        .fontWeight(.semibold)
                                        .foregroundColor(isSelected ? .white : .black)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal,16)
                                        .padding(.vertical, 8)
                                }
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
                            VStack(alignment:.leading){
                                Text("\(item.title)")
                                    .font(.custom("Nunito", size: 18 ))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                if let author = item.author {
                                    HStack {
                                        Text("\(author)")
                                            .font(.custom("Nunito", size: 10 ))
                                            .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                    }
                                }
                            }.padding(16)
                                .frame(maxWidth: .infinity, minHeight: 128)
                                .background(
                                    ZStack {
                                        AsyncImage(url: URL(string: item.urlToImage!), scale: 5) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .cornerRadius(8)
                                            
                                        } placeholder: {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                        }
                                        .frame(height: 240)
                                        LinearGradient(colors: [.black.opacity(0.1),.black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                                        
                                    }
                                )
                                .cornerRadius(8)
                                .clipped()
                            
                        }
//                        ProgressView()
//                            .padding(50)
//                            .onAppear{
//                                viewModel.categoryArticlePage += 1
//                                getLatestNewsByCategory()
//                            }
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
    fileprivate func refresh(){
        viewModel.latestArticles = []
        viewModel.categoryArticles = []
        getLatestNews()
        getLatestNewsByCategory()
    }
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
