//
//  Post.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Date
    var user: User?
    var comments: [Comment]?
    var isLiked: Bool = false
    var lastCommentUser: User?
    var lastCommentText: String?
    var lastCommentUser2: User?
    var lastCommentText2: String?
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is me - Venom!",
              likes: 32,
              imageUrl: "feedImage",
              timestamp: Date(),
              user: User.MOCK_USER[0]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is me - Spiderman!",
              likes: 103,
              imageUrl: "spidermanImage",
              timestamp: Date(),
              user: User.MOCK_USER[1]),
        .init(id: NSUUID().uuidString,
              ownerUid: NSUUID().uuidString,
              caption: "This is me - Batman",
              likes: 99,
              imageUrl: "batmanImage",
              timestamp: Date(),
              user: User.MOCK_USER[2]),
    ]
}
