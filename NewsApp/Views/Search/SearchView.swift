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
                                .onTapGesture {
                                    self.navigationStack.push(ArticleDetailView(article: item))
                                }
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
