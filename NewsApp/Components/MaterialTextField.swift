//
//  MaterialTextField.swift
//  NewsApp
//
//  Created by Sahan Nagodavithana on 2022-07-16.
//

import SwiftUI

enum TextFieldStatus: String {
    case idel = "LightGrey"
    case active = "Blue"
    case danger = "Red"
    case success = "Green"
}

struct MaterialTextField: View {
    @FocusState private var inputTextField: Bool
    let hint: String
    @Binding var text: String
    let status: TextFieldStatus
    let errorMsg: String
    let isSecure: Bool = false
    
    func getColor() -> Color {
        
        switch(status){
        case .idel:
            if inputTextField {
                return .Blue
            }else{
                return Color(status.rawValue)
            }
        case .active:
            return Color(status.rawValue)
        case .danger:
            return Color(status.rawValue)
        case .success:
            return Color(status.rawValue)
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if inputTextField {
                Text(hint)
                    .font(.custom("Poppins", size: 15 ))
                    .foregroundColor(Color.LightBlack)
                    .multilineTextAlignment(.leading)
            }else{
                Text(hint)
                    .font(.custom("Poppins", size: 15 ))
                    .foregroundColor(.clear)
                    .multilineTextAlignment(.leading)
            }
            if isSecure{
                SecureField(inputTextField ? "" : hint, text: $text)
                    .font(.custom("Poppins", size: 15 ))
                    .foregroundColor( text.isEmpty ? .DarkGrey : .black)
                    .keyboardType(.emailAddress)
                    .focused($inputTextField)
            }else{
                TextField(inputTextField ? "" : hint, text: $text)
                    .font(.custom("Poppins", size: 15 ))
                    .foregroundColor( text.isEmpty ? .DarkGrey : .black)
                    .keyboardType(.emailAddress)
                    .focused($inputTextField)
            }
            Rectangle()
                .fill(getColor())
                .frame( height: 2)
                .offset( y: -2)
            Text(errorMsg)
                .font(.custom("Poppins", size: 12 ))
                .foregroundColor(Color.Red)
                .frame(maxWidth: .infinity,  alignment: .leading)
        }
        .padding(.horizontal, 30.0)
    }
}


