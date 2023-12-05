//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import Foundation

@MainActor
class NotificationViewModel: ObservableObject {
    
    @Published var notifications = [Notification]()
    @Published var isLoading = true
    
    let service: NotificationService
    
    init(user: User) {
        self.service = NotificationService(user: user)
        
        Task {
            try await observeNotification()
           isLoading = false
        }
    }
    
    @MainActor
    func observeNotification() async throws {
        service.observeNotifications()  { notification in
            self.notifications.insert(contentsOf: notification, at: 0)
                    
        }
    }
}
