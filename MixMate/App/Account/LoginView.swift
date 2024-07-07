//
//  LoginView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-04.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var authManager: AuthenticationManager
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = LoginViewModel()
    @State var email: String = ""
    @State var password: String = ""
    @State private var isValidEmail: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 40) {
                Text("MixMate")
                    .font(.system(size: 60, weight: .bold))
                
                VStack(spacing: 15) {
                    Text("Welcome back!")
                        .font(.title2)
                }
                
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding(.leading)
                        TextField("email", text: $email)
                            .keyboardType(.emailAddress)                            
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray.opacity(0.5))
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding(.leading)
                        
                        PasswordField(fieldLabel: "password", password: $password)
                    }
                    
                    Button {
                        Task {
                            if await authManager.logIn(email: email, password: password) {
                                if !authManager.isLoading {
                                    dismiss()
                                }
                                
                            }
                        }
                        
                    } label: {
                        if authManager.isLoading {
                            ProgressView()
                                .padding(.vertical, 15)
                        } else {
                            Text("Log in")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 15)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    LoginView()
}
