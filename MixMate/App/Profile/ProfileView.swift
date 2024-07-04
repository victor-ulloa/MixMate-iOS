//
//  ProfileView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-17.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
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
                    Text("Enter your email to sign up for this app")
                        .font(.subheadline)
                }
                
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding(.leading)
                        TextField("email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .onChange(of: email) { _, newValue in
                                viewModel.validateEmail(newValue)
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .padding(.leading)
                        
                        SecureField("password", text: $password)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: password) { _, newValue in
                                viewModel.validatePassword(newValue)
                            }
                        
                        SecureField("confirm password", text: $verifyPassword)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: verifyPassword) { _, newValue in
                                viewModel.validatePasswordMatch(password, newValue)
                            }
                    }
                    
                    Button {
                        viewModel.signUp()
                    } label: {
                        Text("Sign up")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 15)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                
                Button {
                    // Functionality
                } label: {
                    Text("Have an account? Log In instead")
                }
                .frame(maxWidth: .infinity)
                
            }
            .padding(.vertical, 60)
            .padding(.horizontal, 20)
        }
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    ProfileView()
}
