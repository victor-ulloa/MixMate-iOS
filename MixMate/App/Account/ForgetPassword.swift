//
//  ForgetPassword.swift
//  MixMate
//
//  Created by Kanchan Kaur on 2024-08-12.
//

import SwiftUI

struct ForgetPassword: View {
    @EnvironmentObject  var authManager: AuthenticationManager
    @Environment(\.dismiss)  var dismiss
    
    
    @StateObject var viewModel = LoginViewModel()
    @State  var email: String = ""
    @State var password: String = ""
    @State  var showForgetPasswordAlert: Bool = false
    @State  var showResetView: Bool = false
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 40) {
                Text("Forget Your Password?")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.top, 150)
                
                Text("Enter Email Address")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.gray)
               
                
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
                            Text("Reset Password")
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
        .alert(isPresented: $showForgetPasswordAlert) {
           
            Alert(
                title: Text("Forget Password"),
                message: Text("Feature implementation pending"),
                dismissButton: .default(Text("OK"))
            )
        }
        .errorAlert(error: $authManager.error)
    }
}

struct ForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPassword()
            .environmentObject(AuthenticationManager())
    }
}
