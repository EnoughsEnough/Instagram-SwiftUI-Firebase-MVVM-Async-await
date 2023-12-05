//
//  CommentService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import FirebaseAuth
import FirebaseFirestore

struct CommentService {
    
    let post: Post
    
    static func fetchComments() async throws -> [Comment] {
        let snapshot = try await FirestoreConstants
            .PostsCollection
            .document()
            .collection("comments")
            .order(by: "timestamp")
            .limit(to: 2)
            .getDocuments()
        var comments = try snapshot.documents.compactMap({ try $0.data(as: Comment.self ) })
        
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let ownerUid = comment.ownerUid
            let commentUser = try await UserService.fetchUser(withUid: ownerUid)
            
            comments[i].user = commentUser
        }
        
        return comments
    }
    
     func fetchCommentsByPostId() async throws -> [Comment] {
         let snapshot = try await FirestoreConstants.PostsCollection
             .document(post.id)
             .collection("comments")
             .order(by: "timestamp")
             .getDocuments()
         var comments = try snapshot.documents.compactMap({ try $0.data(as: Comment.self ) })
         
         for i in 0 ..< comments.count {
             let comment = comments[i]
             let ownerUid = comment.ownerUid
             let commentUser = try await UserService.fetchUser(withUid: ownerUid)
             
             comments[i].user = commentUser
         }
         
         return comments
    }
    
    func sendCommentPost(message: String) async {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let commentRef = FirestoreConstants.PostsCollection.document(post.id).collection("comments")
        
        let userNotificationRef = FirestoreConstants
            .UsersCollection
            .document(post.user?.id ?? "")
            .collection("notifications")
        
        let user = try? await UserService.fetchUser(withUid: currentUid)
        
        
        let notificaton = Notification(fromUser: user ?? User.MOCK_USER[1],
                                       timestamp: Date(),
                                       image: post.imageUrl,
                                       event: "commented one of your post.")
        
        let encodedNotification = try? Firestore.Encoder().encode(notificaton)
        
        try? await userNotificationRef.document().setData(encodedNotification!)

        
        let commentId = UUID().uuidString  
        
        let comment = Comment(commentId: commentId,
                              ownerUid: currentUid,
                              text: message,
                              timestamp: Date(),
                              postId: post.id)
        
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        
        try? await commentRef.document().setData(commentData)
    }
}
