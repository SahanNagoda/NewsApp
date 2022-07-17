//
//  CategoryButton.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-17.
//

import SwiftUI

struct CategoryButton: View {
    let isSelected: Bool
    let item: String
    var body: some View {
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
