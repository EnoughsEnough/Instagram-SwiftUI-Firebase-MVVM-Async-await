//
//  CommentCellView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import SwiftUI

struct CommentCellView: View {
    let comment: Comment
    
    var body: some View {
        HStack(alignment: .top) {
            NavigationLink(destination: ProfileView(user: comment.user ?? User.MOCK_USER[1])) {
                RoundedImageView(user: comment.user ?? User.MOCK_USER[1], size: .small)
            }
            
            VStack(alignment: .leading) {
                HStack(alignment: .bottom, spacing: 4) {
                    NavigationLink(destination: ProfileView(user: comment.user ?? User.MOCK_USER[1])) {
                        
                        Text(comment.user?.username ?? "")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                    Text(comment.timestamp.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                }
                
                Text(comment.text)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        
    }
}

//#Preview {
//    CommentCellView()
//}
