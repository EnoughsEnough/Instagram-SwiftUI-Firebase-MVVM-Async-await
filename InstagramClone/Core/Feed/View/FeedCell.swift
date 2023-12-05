//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    let post: Post
    let currentUser: String
    @EnvironmentObject private var viewModel: FeedViewModel
    @State private var isLiking = false
    
    var body: some View {
            VStack {
                // image + username
                HStack {
                    if let user = post.user {
                        NavigationLink(destination: ProfileView(user: post.user ?? User.MOCK_USER[1])) {
                            RoundedImageView(user: user,
                                             size: .xSmall)
                            
                            
                            Text(user.username)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.tintColor)
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                
                // post image
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipShape(Rectangle())
                
                // action buttons
                HStack(spacing: 16) {
                    Button {
                        isLiking = true
                        
                        
                        Task {
                            try await viewModel.likePost(post: post,
                                                         uid: currentUser)
                            isLiking = false
                            
                        }
                        
                    } label: {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .imageScale(.large)
                            .foregroundStyle(Color(.systemRed))
                    }
                    .disabled(isLiking)
                    
                    Button {
                        
                    } label: {
                        NavigationLink(destination: CommentView(post: post)) {
                            Image(systemName: "bubble.right")
                                .imageScale(.large)
                                .foregroundStyle(Color.tintColor)
                        }
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                .padding(.top, 4)
                .tint(.black)
                
                // likes label
                
                NavigationLink(destination: LikeListView(postId: post.id)) {
                    Text("\(post.likes) likes")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 10)
                        .padding(.top, 1)
                        .foregroundStyle(Color.tintColor)
                }
                
                // caption label
                
                
                HStack {
                    Text("\(post.user?.username ?? "") ")
                        .fontWeight(.semibold) +
                    Text(post.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .font(.footnote)
                .foregroundStyle(Color.tintColor)
                
                if ((post.lastCommentText2) != nil)  && (post.lastCommentUser2 != nil) {
                    
                    HStack(spacing: 4) {
                        // last - 1 comment
                        NavigationLink(destination: ProfileView(user: post.lastCommentUser2 ?? User.MOCK_USER[1])) {
                            Text(post.lastCommentUser2?.username ?? "")
                                .fontWeight(.semibold)
                        }
                        
                        Text(post.lastCommentText2 ?? "")
                        
                    }
                    .padding(.top, 0.5)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .foregroundStyle(Color.tintColor)
                } else if ((post.lastCommentText) != nil)  && (post.lastCommentUser != nil) {
                    
                    
                    HStack(spacing: 4) {
                        // last comment
                        NavigationLink(destination: ProfileView(user: post.lastCommentUser ?? User.MOCK_USER[1])) {
                            Text(post.lastCommentUser?.username ?? "")
                                .fontWeight(.semibold)
                        }
                        
                        Text(post.lastCommentText ?? "")
                        
                    }
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .foregroundStyle(Color.tintColor)
                } else {
                    EmptyView()
                }
                
                Text(post.timestamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .padding(.top, 0.5)
                    .foregroundStyle(.gray)
            }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS[1], currentUser: "")
}
