//
//  UserService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 28.11.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserService: ObservableObject {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        let query = FirestoreConstants.UsersCollection
        if let limit { query.limit(to: limit) }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    static func fetchUser1(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.UsersCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
    
    static func followUser(withUid uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingUserRef = FirestoreConstants
            .UsersCollection
            .document(uid)
            .collection("followers")
            .document(currentUid)
        
        let userNotificationRef = FirestoreConstants
            .UsersCollection
            .document(uid)
            .collection("notifications")
        
        let user = try await UserService.fetchUser(withUid: currentUid)
        
        let notificaton = Notification(fromUser: user,
                                       timestamp: Date(),
                                       image: "",
                                       event: "started follow you.")
        
        let encodedNotification = try? Firestore.Encoder().encode(notificaton)
        
        let currentUserRef = FirestoreConstants
            .UsersCollection
            .document(currentUid)
            .collection("following")
            .document(uid)
        
        if try await followingUserRef.getDocument().exists {
            try await followingUserRef.delete()
            try await currentUserRef.delete()
        } else {
            try await followingUserRef.setData(["followedBy": currentUid])
            try await currentUserRef.setData(["following": uid])
            try await userNotificationRef.document().setData(encodedNotification!)

        }
    }
    
}
