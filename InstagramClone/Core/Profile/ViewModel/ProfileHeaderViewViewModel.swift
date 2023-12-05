//
//  ProfileHeaderViewViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import Foundation

@MainActor
class ProfileHeaderViewViewModel: ObservableObject {
    @Published var followers: Int = 0
    @Published var following: Int = 0
    @Published var isFollow: Bool = false
    @Published var isLoading: Bool = true
    @Published var posts: Int = 0
    @Published var isFollowed: Bool = false
    @Published var isFollowing: Bool = false
    
    let service: HeaderViewService
    
    init(userId: String) {
        self.service = HeaderViewService(userId: userId)
        Task {
            try await getFollowersCount()
            try await getFollowingCount()
            try await getPostsCount(userId: userId)
            try await isFollowByCurrentUser()
            try await isFollowingByCurrentUser()
            self.isLoading = false
            
        }
    }
    
    @MainActor
    func getFollowersCount() async throws {
        self.followers = try await service.getFollowersCount()
    }
    
    @MainActor
    func getFollowingCount() async throws {
        self.following = try await service.getFollowingCount() 
    }
    
    @MainActor
    func getPostsCount(userId: String) async throws {
        self.posts = try await service.getPostsCount()
    }
    
    @MainActor
    func isFollowByCurrentUser() async throws {
        self.isFollow = try await service.isFollow()
    }
    
    @MainActor
    func isFollowingByCurrentUser() async throws {
        self.isFollowing = try await service.isFollowing()
    }
}
