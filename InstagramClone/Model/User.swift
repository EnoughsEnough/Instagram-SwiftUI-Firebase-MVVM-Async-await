//
//  User.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Hashable,Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USER: [User] = [
        .init(id: NSUUID().uuidString, 
              username: "venom",
              profileImageUrl: nil,
              fullname: "Eddie Brock",
              bio: "Gotham's Dark Knight",
              email: "venom@gmail.com"),
            .init(id: NSUUID().uuidString, 
                  username: "spidey",
                  profileImageUrl: nil,
                  fullname: "Peter Parker",
                  bio: "Friendly Neighborhood Spider-Man",
                  email: "spidey@gmail.com"),
            .init(id: NSUUID().uuidString, 
                  username: "batman",
                  profileImageUrl: nil,
                  fullname: "Bruce Wayne",
                  bio: "The Dark Knight",
                  email: "batman@gmail.com"),
            .init(id: NSUUID().uuidString, 
                  username: "superman",
                  profileImageUrl: nil,
                  fullname: "Clark Kent",
                  bio: "Man of Steel",
                  email: "superman@gmail.com"),
            .init(id: NSUUID().uuidString, 
                  username: "wonderwoman",
                  profileImageUrl: nil,
                  fullname: "Diana Prince",
                  bio: "Amazon Princess",
                  email: "wonderwoman@gmail.com")
    ]
}
