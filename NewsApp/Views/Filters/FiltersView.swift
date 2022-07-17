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
    //MARK: Properties
    @Binding var isPresented: Bool
    @Binding var selectedLanguage: FilterItem?
    @Binding var selectedCountry: FilterItem?
    @StateObject private var viewModel = FiltersViewModel()
    @EnvironmentObject private var navigationStack: NavigationStack

    //MARK: Body
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
                    CategoryButton(isSelected: isSelected, item: item.title)
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
                    CategoryButton(isSelected: isSelected, item: item.title)
                }
            }
            Spacer()
            //MARK: Save Button
            HStack {
                Button {
                    selectedCountry = viewModel.selectedCountry
                    selectedLanguage = viewModel.selectedLanguage
                    isPresented.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 24)
                            .fill(LinearGradient(colors: [.Primary, .LightRed], startPoint: .topLeading, endPoint: .bottomTrailing))
                        HStack {
                            Text("Save")
                                .font(.custom("Nunito", size: 20 ))
                                .fontWeight(.bold)
                                .foregroundColor( .white)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal,16)
                    }
                }
                .frame(height: 48)
                .padding(.bottom, 20)
            }
        }
        .padding(.horizontal, 15)
        .onAppear{
            viewModel.selectedCountry = selectedCountry
            viewModel.selectedLanguage = selectedLanguage
        }
    }
}
