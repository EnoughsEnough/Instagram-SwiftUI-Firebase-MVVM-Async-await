//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 28.11.2023.
//

import Foundation

protocol AuthFormProtocol {
    var formIsValid: Bool { get }
}


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var error: String?
    @Published var isValidation: Bool = false
    
    @MainActor
    func signIn() async throws {
        do {
            try await AuthService.shared.login(with: email, password: password)
        } catch {
            self.error = "Invalid login or password. Please try again."
        }
    }
    
    var isValidPassword: Bool {
        let valid = !password.isEmpty && password.count > 5
        
        return valid
    }
    
    var isValidEmail: Bool {
        let valid = email.contains("@") && !email.isEmpty && email.contains(".")
        return self.isValidation == valid
    }
}
