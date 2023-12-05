//
//  ActiveNowViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 02.12.2023.
//

import Foundation
import FirebaseAuth

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            try await fetchUsers()
        }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.id != currentUid })
    }
}
