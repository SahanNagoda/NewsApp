//
//  CarouselCard.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI
import NavigationStack

struct CarouselCard: View {
    //MARK: Properties
    @EnvironmentObject private var navigationStack: NavigationStack
    
    //MARK: Body
    let item: Article
    var body: some View {
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
            .onTapGesture {
                self.navigationStack.push(ArticleDetailView(article: item))
            }
    }
}
