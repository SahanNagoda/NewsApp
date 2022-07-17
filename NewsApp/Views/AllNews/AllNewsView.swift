//
//  AllNewsView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI
import NavigationStack

struct AllNewsView: View {
    //MARK: Properties
    @StateObject private var viewModel = AllNewsViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack
    
    //MARK: Body
    var body: some View {
        VStack{
            //MARK: App Bar
            ZStack {
                HStack{
                    Button {
                        self.navigationStack.pop()
                    } label: {
                        Image("LeftArrow").colorMultiply(.black)
                    }
                    Spacer()
                    Button {
                        viewModel.showFilter.toggle()
                    } label: {
                        ZStack{
                            Circle()
                                .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 32, height: 32)
                            Image("Filter")
                        }
                    }
                    
                }
                .padding(.horizontal, 15)
                Text("Latest News")
                    .font(.custom("Poppins", size: 22 ))
                    .multilineTextAlignment(.center)
                
            }
            .padding(.top, 20)
            
            //MARK: Articles
            if viewModel.articles.count > 0 {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.articles, id: \.self) { item in
                            NewsDetailCard(item: item)
                            
                        }.padding(.bottom, 20)
                        if viewModel.articles.count < viewModel.totalArticleCount {
                            ProgressView()
                                .padding(30)
                                .onAppear{
                                    viewModel.articlePage += 1
                                    getLatestNewsWithFilter()
                                }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 16)
                }
            }else{
                ProgressView()
                    .padding(50)
                Spacer()
            }
            
        }
        .sheet(isPresented: $viewModel.showFilter, onDismiss: {
            viewModel.articles = []
            getLatestNewsWithFilter()
        }) {
            FiltersView(isPresented: $viewModel.showFilter, selectedLanguage: $viewModel.selectedLanguage, selectedCountry: $viewModel.selectedCountry)
        }
        .onAppear{
            getLatestNewsWithFilter()
        }
    }
}

struct AllNewsView_Previews: PreviewProvider {
    static var previews: some View {
        AllNewsView()
    }
}

//MARK: Functions
extension AllNewsView{
    /// Able to get news with filters
    fileprivate func getLatestNewsWithFilter(){
        viewModel.getLatestNewsWithFilters { status, msg in
            if !status{
                //TODO: Add Error Alert
            }
        }
    }
}
