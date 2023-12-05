//
//  FollowView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 04.12.2023.
//

import SwiftUI

struct FollowView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: FollowViewViewModel
    let userId: String
    
    init(userId: String) {
        self.userId = userId
        self._viewModel = StateObject(wrappedValue: FollowViewViewModel(userId: userId))
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
            .navigationTitle("Followers")
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
    FollowView(userId: "")
}
