//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import Foundation

class CommentViewModel: ObservableObject {
    @Published var comments = [Comment]()
    @Published var text = ""
    @Published var isLoading = true
    
    let service: CommentService
    
    init(post: Post) {
        self.service = CommentService(post: post)
        Task {
            try await fetchPostComments()
        }
    }
    
    @MainActor
    func fetchPostComments() async throws {
        self.comments = try await service.fetchCommentsByPostId()
        isLoading = false
    }
    
    @MainActor
    func sendComment() async throws {
        self.isLoading = true
        try await service.sendCommentPost(message: text)
        text = ""
        try await fetchPostComments()
        self.isLoading = false
    }
    
}
