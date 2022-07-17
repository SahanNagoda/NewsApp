//
//  SearchView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import NavigationStack
import Introspect

struct SearchView: View {
    //MARK: Properties
    @StateObject private var viewModel = SearchViewModel()
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
                        TextField("Search", text: $viewModel.searchText)
                            .onSubmit({
                                if viewModel.searchText.isEmpty {
                                    return
                                }
                                getLatestNewsWithFilter()
                            })
                            .font(.custom("Poppins", size: 12 ))
                            .foregroundColor( viewModel.searchText.isEmpty ? .DarkGrey : .black)
                            .keyboardType(.webSearch)
                            .focused($inputTextField)
                            .frame(width: .infinity)
                            .padding(.leading, 16)
                        Spacer()
                        Button {
                            self.navigationStack.pop()
                        } label: {
                            Image("Close")
                        }
                        .padding(.trailing, 16)
                        
                    }
                    
                }
                
            }.padding(15)
            ScrollView{
                
                //MARK: CATEGORIES
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        Button {
                            viewModel.showFilter.toggle()
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                                
                                HStack {
                                    Image("Filter")
                                    Text("Filter")
                                        .font(.custom("Nunito", size: 12 ))
                                        .fontWeight(.semibold)
                                        .foregroundColor( .white)
                                        .multilineTextAlignment(.center)
                                 }
                                .padding(.vertical, 8)
                                .padding(.horizontal,16)
                            }
                        }
                        
                        
                        ForEach(viewModel.categories, id: \.self) { item in
                            let isSelected = (item == viewModel.selectedCategory)
                            Button {
                                viewModel.selectedCategory = item
                                viewModel.articles = []
                                getLatestNewsWithFilter()
                            } label: {
                                CategoryButton(isSelected: isSelected, item: item)
                            }
                        }
                    }
                    
                    .frame( height: 32)
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                    .padding(.leading, 15)
                    
                }
                if viewModel.isBusy{
                    ProgressView()
                        .padding(50)
                }
                //MARK: CATEGORIES ARTICLES
                if viewModel.articles.count > 0 {
                    VStack {
                        ForEach(viewModel.articles, id: \.self) { item in
                            NewsCard(item: item)
                            
                        }
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 16)
                }
                
                
            }
        }
        .sheet(isPresented: $viewModel.showFilter, onDismiss: {
            getLatestNewsWithFilter()
        }) {
            FiltersView(isPresented: $viewModel.showFilter, selectedLanguage: $viewModel.selectedLanguage, selectedCountry: $viewModel.selectedCountry)
        }
        .onAppear{
            DispatchQueue.main.async {
                inputTextField = true
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

//MARK: Functions
extension SearchView{
    fileprivate func getLatestNews(){
        viewModel.getNewsByKeyword { status, msg in
            if !status{
                //TODO: Add Error Alert
            }
        }
    }
    
    fileprivate func getLatestNewsWithFilter(){
        viewModel.getNewsByCategory { status, msg in
            if !status{
                //TODO: Add Error Alert
            }
        }
    }
}
