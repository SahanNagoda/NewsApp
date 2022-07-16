//
//  DropDown.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI

struct DropDownItem: Hashable {
    let title: String
    let code : String
}

struct DropDown: View {
    @Binding var selectedCode: DropDownItem
    let dropDownList = [
        DropDownItem(title: "United Arab Emirates", code: "+971"),
        DropDownItem(title: "Saudi Arabia", code: "+966"),
    ]
    var body: some View {
        Menu() {
            ForEach(dropDownList, id: \.self){ code in
                Button{
                    selectedCode = code
                }label: {
                    HStack{
                        
                        Text("\(code.title)")
                    }
                }
            }
        } label: {
            
            VStack(spacing: 5){
                HStack(spacing: 10){
                    
                    Text(selectedCode.title)
                        .font(.custom("Poppins", size: 15 ))
                    Image(systemName: "chevron.down")
                        .foregroundColor(.DarkGrey)
                        .font(Font.system(size: 15, weight: .bold))
                }
                .padding(.horizontal)
                
            }
            .frame(width: 150)
        }.frame(width: 110)
    }
}

struct DropDown_Previews: PreviewProvider {
    static var previews: some View {
        DropDown(selectedCode: .constant(DropDownItem(title: "Sri Lanka", code: "SL")))
    }
}
