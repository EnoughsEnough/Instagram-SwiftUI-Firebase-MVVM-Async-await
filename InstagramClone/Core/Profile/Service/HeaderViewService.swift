//
//  HeaderViewService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 04.12.2023.
//

import FirebaseAuth
import Foundation

struct HeaderViewService {
    
    let userId: String
    
    func getFollowersCount() async throws -> Int {
        let snapshot = try await FirestoreConstants
            .UsersCollection
            .document(userId)
            .collection("followers")
            .getDocuments()
        
        let users = snapshot.documents.compactMap({ $0.data()["followedBy"] })
        
        return users.count
    }
    
    func getFollowingCount() async throws -> Int {
        let snapshot = try await FirestoreConstants
            .UsersCollection
            .document(userId)
            .collection("following")
            .getDocuments()
        
        let users = snapshot.documents.compactMap({ $0.data()["following"] })

        return users.count
    }
    
    func getPostsCount() async throws -> Int {
        let snapshot = try await FirestoreConstants
            .PostsCollection
            .whereField("ownerUid", isEqualTo: userId)
            .getDocuments()

        return snapshot.count
    }
    
    func isFollow() async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirestoreConstants
            .UsersCollection
            .document(currentUid)
            .collection("followers")
            .whereField("followedBy", isEqualTo: userId)
            .getDocuments()
        
        return !snapshot.documents.isEmpty
    }
    
    func isFollowing() async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirestoreConstants
            .UsersCollection
            .document(currentUid)
            .collection("following")
            .whereField("following", isEqualTo: userId)
            .getDocuments()
        
        return !snapshot.documents.isEmpty
    }
}
