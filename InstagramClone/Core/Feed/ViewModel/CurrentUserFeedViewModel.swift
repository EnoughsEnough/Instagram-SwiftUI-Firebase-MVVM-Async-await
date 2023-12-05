//
//  CurrentUserFeedViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import Foundation

class CurrentUserFeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var user: User
    
    init(user: User) {
        self.user = user
        
        Task {
            try await fetchUserPosts()
        }
        

    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            posts[i].user = self.user
            
            let postComment = try await FirestoreConstants
                .PostsCollection
                .document(post.id)
                .collection("comments")
                .order(by: "timestamp")
                .limit(toLast: 2)
                .getDocuments()
                .documents
                .compactMap({ try $0.data(as: Comment.self)})
            
            if !postComment.isEmpty {
                posts[i].lastCommentText = postComment.last?.text
                posts[i].lastCommentText2 = postComment.first?.text
                posts[i].lastCommentUser = try await UserService.fetchUser(withUid: postComment.last?.ownerUid ?? "")
                posts[i].lastCommentUser2 = try await UserService.fetchUser(withUid: postComment.first?.ownerUid ?? "")
            }
        }
        
    }
}
