//
//  ProfileView.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-06-17.
//

import SwiftUI

struct ProfileView: View {
    
    @State var email: String = ""
    @State var pasword: String = ""
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
                    TextField("email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onChange(of: email) { _, newValue in
                            isValidEmail = validateEmail(email: newValue)
                            print(isValidEmail)
                        }
                    
                    TextField("password", text: $pasword)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                    
                    TextField("confirmpassword", text: $verifyPassword)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                    
                    Button {
                        // Functionality
                        // call a viewModel funtion
                        // go next view
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
