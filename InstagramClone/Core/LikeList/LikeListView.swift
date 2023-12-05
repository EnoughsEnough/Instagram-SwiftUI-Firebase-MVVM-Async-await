//
//  LikeListView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import SwiftUI

struct LikeListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: LikeListViewModel
    let postId: String
    
    init(postId: String) {
        self.postId = postId
        self._viewModel = StateObject(wrappedValue: LikeListViewModel(postId: postId))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.0)
                        .padding()
                } else {
                    LazyVStack {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: ProfileView(user: user)) {
                                UserListView(user: user)
                            }
                        }
                    }
                }
            }
            .padding(.top)
            .navigationTitle("Likes")
            .navigationBarBackButtonHidden()
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}

#Preview {
    LikeListView(postId: "")
}
