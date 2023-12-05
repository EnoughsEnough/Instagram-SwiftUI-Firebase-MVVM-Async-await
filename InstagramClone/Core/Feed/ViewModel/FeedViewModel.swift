//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 28.11.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var currentUser: String?
    
    init() {
        Task {
            try await fetchPosts()
        }
        
        Task {
            try await getCurrentUser()
        }
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPostsAndComments()
    }
    
    @MainActor
    func likePost(post: Post, uid: String) async throws {
        
        let postRef = FirestoreConstants
            .PostsCollection
            .document(post.id)
        
        let likesCollectionRef = postRef.collection("likes")
        
                let snapshot = try await likesCollectionRef.document(uid).getDocument()
        
        
            let userNotificationRef = FirestoreConstants
                .UsersCollection
                .document(post.user?.id ?? "")
                .collection("notifications")
        
        let user = try await UserService.fetchUser(withUid: uid)
            
        let notificaton = Notification(fromUser: user,
                                           timestamp: Date(),
                                       image: post.imageUrl,
                                           event: "liked one of your posts.")
            
            let encodedNotification = try Firestore.Encoder().encode(notificaton)
                
                if snapshot.exists {
                    if let index = posts.firstIndex(where: { $0.id == post.id }) {
                        posts[index].likes  -= 1
                        posts[index].isLiked = false
                        
                    
                    }
                    
                    try await likesCollectionRef.document(uid).delete()
                    try await postRef.updateData(["likes": post.likes - 1])
                } else {
                    if let index = posts.firstIndex(where: { $0.id == post.id }) {
                        posts[index].likes  += 1
                        posts[index].isLiked = true
                    }
                    
                    
                    
                        
                        try await likesCollectionRef.document(uid).setData(["likedBy": uid])
                        try await postRef.updateData(["likes": post.likes + 1])
                    try await userNotificationRef.document().setData(encodedNotification)
                
                }
        
            try await fetchPosts()
            }
    
    
    @MainActor
    func getCurrentUser() async throws {
        guard let user = Auth.auth().currentUser?.uid else { return }
        self.currentUser = user
    }
}
