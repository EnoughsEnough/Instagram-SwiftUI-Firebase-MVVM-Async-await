//
//  InboxRowView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 01.12.2023.
//

import SwiftUI

struct InboxRowView: View {
    let message: Message
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 14) {
                RoundedImageView(user: message.user!, size: .medium)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(message.user?.username ?? "")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(message.timestamp.timestampString())
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                    }
                    
                    Text(message.messageText)
                        .font(.footnote)
                }
                .foregroundStyle(Color.tintColor)
                                
                Spacer()
            }    
         
        }
    }
}

//#Preview {
//    InboxRowView()
//}
