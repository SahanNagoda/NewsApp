//
//  NewsDetailCard.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI
import NavigationStack

struct NewsDetailCard: View {
    let item: Article
    @EnvironmentObject private var navigationStack: NavigationStack
    
    var body: some View {
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
        .onTapGesture {
            self.navigationStack.push(ArticleDetailView(article: item))
        }
    }
}
