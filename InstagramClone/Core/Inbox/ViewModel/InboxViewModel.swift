//
//  InboxViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 01.12.2023.
//

import Foundation
import Combine
import FirebaseAuth
import Firebase

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] changes in
            self?.LoadInitialMessages(fromChanges: changes)
        }.store(in: &cancellables)
    }
    
    private func LoadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
        
        for i in 0 ..< messages.count {
            let message = messages[i]
            
            UserService.fetchUser1(withUid: message.chatPartnerId) { user in
                    messages[i].user = user

                
                if let existingMessageIndex = self.recentMessages.firstIndex(where: { $0.chatPartnerId == message.chatPartnerId }) {
                               // Replace the existing message only if the timestamp of the new message is greater
                               if messages[i].timestamp > self.recentMessages[existingMessageIndex].timestamp {
                                   self.recentMessages[existingMessageIndex] = messages[i]
                               }
                           } else {
                               // Add the new message if it doesn't exist in recentMessages
                               self.recentMessages.append(messages[i])
                           }
            }
        }
    }
    
    
}
