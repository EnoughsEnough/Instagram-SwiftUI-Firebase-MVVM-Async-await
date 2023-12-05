//
//  Constatns.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 01.12.2023.
//

import Foundation
import FirebaseFirestore

struct FirestoreConstants {
    static let UsersCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
    static let PostsCollection = Firestore.firestore().collection("posts")
}
