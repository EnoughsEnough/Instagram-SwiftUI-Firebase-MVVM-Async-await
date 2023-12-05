//
//  Comment.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 02.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct Comment: Identifiable, Hashable, Codable {
    @DocumentID var commentId: String?
    let ownerUid: String
    let text: String
    let timestamp: Date
    var user: User?
    let postId: String
    
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
}
