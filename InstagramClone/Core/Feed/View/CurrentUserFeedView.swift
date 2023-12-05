//
//  CurrentUserFeedView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import SwiftUI

struct CurrentUserFeedView: View {
    let user: User
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: CurrentUserFeedViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: CurrentUserFeedViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach (viewModel.posts) { post in
                    FeedCell(post: post, currentUser: user.id)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .padding(.top)
                }
            }
            .navigationTitle(user.username + " posts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundStyle(Color.tintColor)
                }
            }
        }
    }
}

//#Preview {
//    CurrentUserFeedView(user: User.MOCK_USER[1], post: Post.MOCK_POSTS[1])
//}
