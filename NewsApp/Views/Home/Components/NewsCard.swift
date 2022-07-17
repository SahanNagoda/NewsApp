//
//  NewsCard.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI
import NavigationStack

struct NewsCard: View {
    let item: Article
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
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

