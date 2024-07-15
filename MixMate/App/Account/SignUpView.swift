//
//  SignUpView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-04.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject private var authManager: AuthenticationManager
    
    @StateObject var viewModel = SignUpViewModel()
    
    @State var email: String = ""
    @State var password: String = ""
    @State var verifyPassword: String = ""
    @State private var isValidEmail: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 40) {
                Text("MixMate")
                    .font(.system(size: 60, weight: .bold))
                
                VStack(spacing: 15) {
                    Text("Create an account")
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
                            .onChange(of: email) { _, newValue in
                                viewModel.validateEmail(newValue)
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding(.leading)
                        
                        PasswordField(fieldLabel: "password", password: $password)
                            .onChange(of: password) { _, newValue in
                                viewModel.validatePassword(newValue)
                            }
                        
                        PasswordField(fieldLabel:"confirm password", password: $verifyPassword)
                            .onChange(of: verifyPassword) { _, newValue in
                                viewModel.validatePasswordMatch(password, newValue)
                            }
                    }
                    
                    Button {
                        if !viewModel.isEmailValid {
                            print("Handle invalid email")
                            return
                        }
                        
                        if !viewModel.isPasswordValid {
                            print("Password not valid")
                            return
                        }
                        
                        if !viewModel.passwordsMatch {
                            print("Passwords do not match")
                            return
                        }
                        Task {
                            await authManager.signUp(email: email, password: password)
                        }
                    } label: {
                        if authManager.isLoading {
                            ProgressView()
                                .padding(.vertical, 15)
                        } else {
                            Text("Sign up")
                                .font(.title3)
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 15)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
                NavigationLink {
                    LoginView()
                        .environmentObject(authManager)
                } label: {
                    Text("Have an account? Log In instead")
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(.vertical, 60)
            .padding(.horizontal, 20)
        }
        .errorAlert(error: $authManager.error)
    }
}

#Preview {
    NavigationStack{
        SignUpView()
            .environmentObject(AuthenticationManager())
    }
}
