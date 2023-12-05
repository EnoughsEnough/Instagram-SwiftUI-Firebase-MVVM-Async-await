//
//  NotificationService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 04.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct NotificationService {
    
    let user: User
    
    func observeNotifications(completion: @escaping([Notification]) -> Void) {
       guard let currentUid = Auth.auth().currentUser?.uid else { return }
       
        let query = FirestoreConstants
            .UsersCollection
           .document(currentUid)
           .collection("notifications")
           .order(by: "timestamp", descending: true)
       
        
       // ask our service about any new changes in our document
       query.addSnapshotListener { snapshot, _ in
           guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
           let notification = changes.compactMap({ try? $0.document.data(as: Notification.self) })
           

//           print(notification)
           completion(notification)
       }
        
   }
}
