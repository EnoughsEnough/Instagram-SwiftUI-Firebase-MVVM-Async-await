//
//  ChatMessageCell.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 30.11.2023.
//

import Kingfisher
import SwiftUI

struct ChatMessageCell: View {
    let message: Message
    
    private var isFromCurrentUser: Bool {
        return message.isFromCurrentUser
    }
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                VStack(alignment: .trailing) {
                    
                    if message.messageText.isEmpty {
                        
                        KFImage(URL(string: message.imageUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))

                    } else {
                        
                        
                        Text(message.messageText)
                            .font(.subheadline)
                            .padding(12)
                            .background(Color(.systemBlue))
                            .foregroundStyle(.white)
                            .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                            .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                    }
                    
                }
                    
                
                    
                
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    NavigationLink(destination: ProfileView(user: message.user ?? User.MOCK_USER[1])) {
                        RoundedImageView(user: message.user ?? User.MOCK_USER[1], size: .xSmall)
                    }
                    VStack(alignment: .leading) {
                        
                        if message.messageText.isEmpty {
                            KFImage(URL(string: message.imageUrl ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        } else {
                            
                            
                            
                            Text(message.messageText)
                                .font(.subheadline)
                                .padding()
                                .background(Color(.systemGray5))
                                .foregroundStyle(.black)
                                .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                                .frame(maxWidth: UIScreen.main.bounds.width / 1.75, alignment: .leading)
                        }
                        
                        
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ChatMessageCell(message: Message(messageId: "", fromId: "dsa", toId: "ds", messageText: "dasdas", timestamp: Date(), imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-23d03.appspot.com/o/profile_images%2F1FA212E8-D5D8-48FB-93EB-010953DC9129?alt=media&token=3f09cc05-42bb-411f-8d36-09c887435455"))
}
