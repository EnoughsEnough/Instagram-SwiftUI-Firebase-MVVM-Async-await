//
//  FollowViewViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import Foundation

class FollowViewViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = true
    
    let service: FollowService
    
    init(userId: String) {
        self.service = FollowService(userId: userId)
        Task {
            try await fetchFollowers()
        }
    }
    
    @MainActor
    func fetchFollowers() async throws {
        self.users = try await service.getFollowers()
        isLoading = false
    }
    
}
