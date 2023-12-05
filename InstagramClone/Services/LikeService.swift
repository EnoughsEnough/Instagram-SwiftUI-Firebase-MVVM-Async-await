//
//  LikeService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import FirebaseFirestore

struct LikeService {
    
    let postId: String

     func fetchLikes() async throws -> [User] {
        let snapshot = try await FirestoreConstants
            .PostsCollection
            .document(postId)
            .collection("likes")
            .getDocuments()
         
            
         let userIDs = snapshot.documents.compactMap({ $0.data()["likedBy"] })

         var users: [User] = []
         
         for userId in userIDs {
                do {
                    let userDocument = try await Firestore.firestore().collection("users").document(userId as! String).getDocument()
                    if let userData = userDocument.data() {
                        // Создайте объект User на основе данных пользователя
                        // Предположим, что у вас есть функция, создающая объект User из данных
                        let user = try await UserService.fetchUser(withUid: userId as! String)
                        users.append(user)
                    }
                } catch {
                    print("Ошибка при получении данных пользователя с ID \(userId): \(error.localizedDescription)")
                }
            }
         
        return users
    }
}
