//
//  RegistrationViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        try? await AuthService.shared.createUser(with: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
