//
//  ChatService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 01.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct ChatService {
    
    let chatPartner: User
    
    func sendMessage(_ messageText: String, imageUrl: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let messageId = UUID().uuidString
        
        let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document(messageId)
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid).document(messageId)
        
        let recentCurrentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
        
        
        let message = Message(messageId: messageId,
                              fromId: currentUid,
                              toId: chatPartnerId,
                              messageText: messageText,
                              timestamp: Date(),
                              imageUrl: imageUrl
        )
        
        
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.setData(messageData)
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
    }

    
     func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
         let query = FirestoreConstants.MessagesCollection	
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        // ask our service about any new changes in our document
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where !message.isFromCurrentUser {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
