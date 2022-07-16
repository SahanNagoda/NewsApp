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
            ZStack {
                HStack{
                    Button {
                        self.navigationStack.pop()
                    } label: {
                        Image("LeftArrow").colorMultiply(.black)
                    }
                    Spacer()
                    ZStack{
                        Circle()
                            .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 32, height: 32)
                        Image("Filter")
                    }
                }
                .padding(.horizontal, 15)
                Text("Latest News")
                    .font(.custom("Poppins", size: 22 ))
                    .multilineTextAlignment(.center)
                
            }
            .padding(.top, 20)
            if viewModel.articles.count > 0 {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.articles, id: \.self) { item in
                            VStack(alignment: .leading) {
                                VStack(alignment:.leading){
                                    
                                    Spacer()
                                    
                                }.padding(16)
                                    .frame(maxWidth: .infinity, minHeight: 128)
                                    .background(
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
                                    )
                                    .cornerRadius(8)
                                .clipped()
                                Text("\(item.title)")
                                    .font(.custom("Nunito", size: 15 ))
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                Text("\(item.content ?? "")")
                                    .font(.custom("Nunito", size: 14 ))
                                    .foregroundColor(.black.opacity(0.7))
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                    .padding(.top,1)
                                if let author = item.author {
                                    
                                        Text("Published by \(author)")
                                            .font(.custom("Nunito", size: 12 ))
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                            .padding(.top,1)
                                            
                                    
                                }
                            }
                            
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

extension AllNewsView{
    fileprivate func getLatestNewsWithFilter(){
        viewModel.getLatestNewsWithFilters { status, msg in
            if !status{
                //TODO: Add Error Alert
            }
        }
    }
}
