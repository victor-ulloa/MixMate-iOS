//
//  ProfileViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-04.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var passwordsMatch = false
    
    func validateEmail(_ email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isEmailValid = emailPred.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) {
        // Check for at least one capital letter and one number
        let capitalLetterRegex = ".*[A-Z]+.*"
        let numberRegex = ".*[0-9]+.*"
        
        let capitalLetterTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex)
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        isPasswordValid = capitalLetterTest.evaluate(with: password) && numberTest.evaluate(with: password)
        print(isPasswordValid)
    }
    
    func validatePasswordMatch(_ password: String, _ passwordVerification: String) {
        passwordsMatch = password == passwordVerification
    }
    
    func signUp() {
        if !isEmailValid {
            print("Handle invalid email")
            return
        }
        
        if !isPasswordValid {
            print("Password not valid")
            return
        }
        
        if !passwordsMatch {
            print("Passwords do not match")
            return
        }
        
    }
}
