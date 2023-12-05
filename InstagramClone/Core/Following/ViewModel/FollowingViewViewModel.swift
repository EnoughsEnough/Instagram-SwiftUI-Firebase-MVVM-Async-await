//
//  FollowingViewViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 04.12.2023.
//

import Foundation

class FollowingViewViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = true
    
    let service: FollowService
    
    init(userId: String) {
        self.service = FollowService(userId: userId)
        Task {
            try await fetchFollowing()
        }
    }
    
    @MainActor
    func fetchFollowing() async throws {
        self.users = try await service.getFollowing()
        isLoading = false
//        print(user)
    }
    
}
