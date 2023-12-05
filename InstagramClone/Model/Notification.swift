//
//  Notification.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 04.12.2023.
//

import Foundation
import FirebaseFirestoreSwift

enum NotificationEvent {
    case likePost
    case follow
    case commentPost
}

struct Notification: Identifiable, Codable, Hashable {
    @DocumentID var notificationId: String?
    let fromUser: User
    let timestamp: Date
    let image: String?
    let event: String
    
    var id: String {
        return notificationId ?? NSUUID().uuidString
    }
}
