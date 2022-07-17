//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI
import NavigationStack

struct ArticleDetailView: View {
    //MARK: Properties
    let article: Article
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        GeometryReader {reading in
            ZStack(alignment: .top) {
                //MARK: Background
                VStack{
                    AsyncImage(url: URL(string: article.urlToImage!), scale: 5) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                        
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    .ignoresSafeArea()
                    .frame(height: reading.size.height*0.7)
                    Spacer()
                }
                .frame(maxWidth: reading.size.width)
                
                //MARK: Foreground
                VStack{
                    ScrollView{
                        ZStack(alignment: .top) {
                            VStack{
                                if let content = article.content{
                                    Text("\(content)\n\n\(content)\n\n\(content)")
                                        .font(.custom("Nunito", size: 17 ))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal, 15)
                                        .padding(.top, 70)
                                }else{
                                    Text("No Content is Found!")
                                        .font(.custom("Nunito", size: 17 ))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal, 15)
                                        .padding(.top, 70)
                                }
                                
                                Spacer()
                                
                            }
                            .frame(maxWidth: reading.size.width, minHeight: reading.size.height*0.6)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.white)
                                
                            )
                            .padding(.top, 80)
                            
                            VStack(alignment: .leading,spacing: 8){
                                Text(article.title)
                                    .font(.custom("Nunito", size: 17 ))
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: .infinity)
                                if let author = article.author {
                                    Text("Published by \(author)")
                                        .font(.custom("Nunito", size: 12 ))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                }
                                
                            }
                            .padding(24)
                            .frame(maxWidth: 320, idealHeight: 141)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                            )
                        }
                        .padding(.top, 300)
                        
                    }
                    
                    .frame(maxWidth: reading.size.width)
                }
                //MARK: App Bar
                HStack{
                    Button {
                        self.navigationStack.pop()
                    } label: {
                        Image("LeftArrow")
                            .colorMultiply(.black)
                    }
                    .frame(width: 32, height: 32)
                    .background(
                        .ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                        
                    )
                    Spacer()
                    
                    
                }
                .padding(.horizontal, 15)
            }
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: articleMock)
    }
}
let articleMock: Article = Article(author: "Sahan", title: "Crypto investors should be prepared to lose all their money, BOE governor says", articleDescription: "", url: "", urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/220716073629-05-biden-saudi-arabia-0716-super-tease.jpg", content: "LONDON — Cryptocurrencies \\“have no intrinsic value\\” and people who invest in them should be prepared to lose all their money, Bank of England Governor Andrew Bailey said.\n\nDigital currencies like bitcoin, ether and even dogecoin have been on a tear this year,")
