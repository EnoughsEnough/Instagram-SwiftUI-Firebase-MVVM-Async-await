//
//  LikeListViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import Foundation

class LikeListViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = true
    
    let service: LikeService
    
    init(postId: String) {
        self.service = LikeService(postId: postId)
        Task {
            try await fetchPostComments()
        }
    }
    
    @MainActor
    func fetchPostComments() async throws {
        self.users = try await service.fetchLikes()
        isLoading = false
    }
    
    
}
