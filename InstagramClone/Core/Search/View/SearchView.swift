//
//  SearchView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject var viewModel = SearchViewModel()
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                return user.username.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                        ForEach(filteredUsers) { user in
                            NavigationLink(value: user) {
                                UserListView(user: user)
                            }
                        }
    
                }
                
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Search...")
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
