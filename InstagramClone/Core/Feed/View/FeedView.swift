//
//  FeedView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.posts.isEmpty {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.0)
                        .padding()
                } else {
                    LazyVStack(spacing: 32) {
                        ForEach(viewModel.posts) { post in
                            NavigationLink(value: post) {
                                FeedCell(post: post, currentUser: viewModel.currentUser ?? "")
                                    .environmentObject(viewModel)
                                
                            }
                            .foregroundStyle(.black)
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("instagramLogo")
                        .resizable()
                        .frame(width: 100, height: 32)
                }
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: InboxView()) {
                            Image(systemName: "paperplane")
                                .imageScale(.large)
                                .foregroundStyle(Color.tintColor)
                        }
                }
            }
            .refreshable {
                Task {
                    try await viewModel.fetchPosts()
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
