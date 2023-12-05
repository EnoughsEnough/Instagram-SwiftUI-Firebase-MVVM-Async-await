//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    @State private var showEditProfile = false
    @StateObject private var viewModel: ProfileHeaderViewViewModel
        
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ProfileHeaderViewViewModel(userId: user.id))
    }
    
    var body: some View {
        VStack(spacing: 10) {
                HStack {
                    RoundedImageView(user: user, size: .large)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        UserStackView(value: viewModel.posts, title: "Posts")
                        
                        NavigationLink(destination: FollowView(userId: user.id)) {
                            UserStackView(value: viewModel.followers, title: "Followers")
                        }
                        NavigationLink(destination: FollowingView(userId: user.id)) {
                            UserStackView(value: viewModel.following, title: "Following")
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 4)
                
                //name and bio
                VStack(alignment: .leading, spacing: 4) {
                    if let fullname = user.fullname {
                        Text(fullname)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                    if let bio = user.bio {
                        Text(bio)
                            .font(.footnote)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // action button
            
            if user.isCurrentUser {
                Button {
                    showEditProfile.toggle()
                } label: {
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 32)
                        .background(user.isCurrentUser ? .white : Color(.systemBlue))
                        .foregroundStyle(user.isCurrentUser ? .black : .white)
                        .cornerRadius(6)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(user.isCurrentUser ? .gray : .clear, lineWidth: 1)
                        }
                }
            } else if viewModel.isFollow && viewModel.isFollowing {
                Button {
                        Task {
                            try await UserService.followUser(withUid: user.id)
                            try await viewModel.isFollowByCurrentUser()
                            try await viewModel.isFollowingByCurrentUser()
                        }
                } label: {
                    Text(
                        "Follow you"
                    )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 32)
                        .background(.white)
                        .foregroundStyle(.black)
                        .cornerRadius(6)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.gray, lineWidth: 1)
                        }
                }
            } else if !viewModel.isFollow && viewModel.isFollowing {
                Button {
                        Task {
                            try await UserService.followUser(withUid: user.id)
                            try await viewModel.isFollowByCurrentUser()
                            try await viewModel.isFollowingByCurrentUser()
                        }
                } label: {
                    HStack {
                        Text(
                            "You are following \(user.username)"
                        )
                    }
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .frame(width: 360, height: 32)
                    .background(.white)
                    .foregroundStyle(.black)
                    .cornerRadius(6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 1)
                    }
                }
            } else if !viewModel.isFollow && !viewModel.isFollowing {
                Button {
                    Task {
                        try await UserService.followUser(withUid: user.id)
                        try await viewModel.isFollowByCurrentUser()
                        try await viewModel.isFollowingByCurrentUser()
                    }
                } label: {
                    Text(
                        "Follow"
                    )
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 360, height: 32)
                        .background(Color(.systemBlue))
                        .foregroundStyle(.white)
                        .cornerRadius(6)
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.clear, lineWidth: 1)
                        }
                }
            } else if !viewModel.isFollow {
                Button {
                    Task {
                        try await UserService.followUser(withUid: user.id)
                        try await viewModel.isFollowByCurrentUser()
                        try await viewModel.isFollowingByCurrentUser()
                    }
                } label: {
                    Text(
                        "Follow"
                    )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .cornerRadius(6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.clear, lineWidth: 1)
                    }
                }
            } else if viewModel.isFollow {
                Button {
                    Task {
                        try await UserService.followUser(withUid: user.id)
                        try await viewModel.isFollowByCurrentUser()
                        try await viewModel.isFollowingByCurrentUser()
                    }
                } label: {
                    Text(
                        "Follow you"
                    )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(.white)
                    .foregroundStyle(.black)
                    .cornerRadius(6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.gray, lineWidth: 1)
                    }
                }
            }
                
                Divider()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

//#Preview {
//    ProfileHeaderView(user: User.MOCK_USER[1])
//}
