//
//  SignUpViewModel.swift
//  MixMate
//
//  Created by Victor Ulloa on 2024-07-04.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var passwordsMatch = false
    
    func validateEmail(_ email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        isEmailValid = emailPred.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) {
        
        let capitalLetterRegex = ".*[A-Z]+.*"
        let numberRegex = ".*[0-9]+.*"
        
        let capitalLetterTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex)
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        
        isPasswordValid = capitalLetterTest.evaluate(with: password) && numberTest.evaluate(with: password)
    }
    
    func validatePasswordMatch(_ password: String, _ passwordVerification: String) {
        passwordsMatch = password == passwordVerification
    }
}
