//
//  PostService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 28.11.2023.
//

import FirebaseFirestore
import FirebaseAuth

struct PostService {
        
    static func fetchFeedPostsAndComments() async throws -> [Post] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let postSnapshot = try await FirestoreConstants.PostsCollection
            .order(by: "timestamp", descending: true)
            .getDocuments()

        var posts = try postSnapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            
            let postComment = try await FirestoreConstants
                .PostsCollection
                .document(post.id)
                .collection("comments")
                .order(by: "timestamp")
                .limit(toLast: 2)
                .getDocuments()
                .documents
                .compactMap({ try $0.data(as: Comment.self)})
            
            
            let postLike = try await FirestoreConstants
                .PostsCollection
                .document(post.id)
                .collection("likes")
                .document(currentUid)
                .getDocument()
                .exists
            
    
            if !postComment.isEmpty {
                posts[i].lastCommentText = postComment.last?.text
                posts[i].lastCommentText2 = postComment.first?.text
                posts[i].lastCommentUser = try await UserService.fetchUser(withUid: postComment.last?.ownerUid ?? "")
                posts[i].lastCommentUser2 = try await UserService.fetchUser(withUid: postComment.first?.ownerUid ?? "")
            }
            
            posts[i].user = postUser
            posts[i].isLiked = postLike
        }
        
        return posts
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await FirestoreConstants.PostsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
    
    static func fetchLikesForPost() async throws {
        
    }
       
}
