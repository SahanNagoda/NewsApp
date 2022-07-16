//
//  FiltersView.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI
import WrappingHStack
import NavigationStack

struct FilterItem: Hashable {
    let title: String
    let code : String
}

struct FiltersView: View {
    @StateObject private var viewModel = FiltersViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Filter")
                    .font(.custom("Poppins", size: 22 ))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    
                Spacer()
                Button {
                    viewModel.selectedCountry = nil
                    viewModel.selectedLanguage = nil
                } label: {
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 1)
                        
                        
                        HStack {
                            Image("Reset")
                            Text("Reset")
                                .font(.custom("Nunito", size: 12 ))
                                .fontWeight(.semibold)
                                .foregroundColor( .black)
                                .multilineTextAlignment(.center)
                            
                            
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal,16)
                    }
                }
                .frame(width: 85,height: 32)
                
            }
            .padding(.top, 15)
            
            //MARK: BY Country
            Text("By Country")
                .font(.custom("Poppins", size: 14 ))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.top, 15)
                .padding(.bottom, 10)
            WrappingHStack(viewModel.countries, id: \.self, alignment: .leading, spacing: .constant(10), lineSpacing: 10) {item in
                let isSelected = (item.code == viewModel.selectedCountry?.code ?? "")
                
                Button {
                    viewModel.selectedCountry = item
                } label: {
                    ZStack{
                        if isSelected {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }else{
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.LightGrey, lineWidth: 1)
                        }
                        
                        Text(item.title)
                            .font(.custom("Nunito", size: 12 ))
                            .fontWeight(.semibold)
                            .foregroundColor(isSelected ? .white : .black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,16)
                            .padding(.vertical, 8)
                    }
                }
            }
            
            //MARK: BY Language,
            Text("By Language,")
                .font(.custom("Poppins", size: 14 ))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.top, 15)
                .padding(.bottom, 10)
            WrappingHStack(viewModel.language, id: \.self, alignment: .leading, spacing: .constant(10), lineSpacing: 10) {item in
                let isSelected = (item.code == viewModel.selectedLanguage?.code ?? "")
                
                Button {
                    viewModel.selectedLanguage = item
                } label: {
                    ZStack{
                        if isSelected {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                        }else{
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.LightGrey, lineWidth: 1)
                        }
                        
                        Text(item.title)
                            .font(.custom("Nunito", size: 12 ))
                            .fontWeight(.semibold)
                            .foregroundColor(isSelected ? .white : .black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,16)
                            .padding(.vertical, 8)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 15)
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}
