//
//  NotificationRowView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import SwiftUI
import Kingfisher

struct NotificationRowView: View {
    let notification: Notification
    
    
    var body: some View {
            
            HStack(spacing: 5) {
                    RoundedImageView(user: notification.fromUser, size: .xSmall)
                    
                    Text(notification.fromUser.username)
                        .fontWeight(.semibold)
                
                
                Text(notification.event)
                    .lineLimit(1)
                
                Text(notification.timestamp.timestampString())
                    .foregroundStyle(.gray)
                
                Spacer()
                
                KFImage(URL(string: notification.image ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Rectangle())
            }
            .font(.system(size: 12))
            .padding(.horizontal)
            .font(.footnote)
        }
}

#Preview {
    NotificationRowView(notification: Notification(fromUser: User.MOCK_USER[1], timestamp: Date(), image: "", event: "started follow you."))
}
