//
//  PasswordField.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-04.
//

import SwiftUI

struct PasswordField: View {
    
    var fieldLabel = ""
    @State var isShowingPassword: Bool = false
    @Binding var password: String
    
    var body: some View {
        HStack{
            if isShowingPassword {
                TextField(text: $password) {
                    Text(fieldLabel)
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
            } else {
                SecureField(text: $password) {
                    Text(fieldLabel)
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
            }
            
            
            Button {
                isShowingPassword.toggle()
            } label: {
                Image(systemName: isShowingPassword ? "eye" : "eye.slash")
                    .foregroundStyle(.gray)
            }
            .padding()
            
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.5))
        }
    }
}

#Preview {
    @State var password: String = ""
    return PasswordField(fieldLabel: "password", password: $password)
}
