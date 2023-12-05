//
//  CurrentUserProfileView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI

struct Setting: Identifiable, Hashable {
    var id: Int
    var icon: String
    var title: String
}


struct CurrentUserProfileView: View {
    
    @State private var isModalOpened = false
    
    
    let settings: [Setting] = [
         Setting(id: 1,icon: "gear", title: "Edit Profile"),
         Setting(id: 2,icon: "door.left.hand.open", title: "Sign out"),
        ]
    
    let user: User
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // header
                ProfileHeaderView(user: user)
                    
                
                // post grid view
                ScrollView {
                        PostGridView(user: user)
                }
                
                Spacer()
                            
            }
            .toolbar(isModalOpened ? .hidden : .visible, for: .tabBar)
            .navigationTitle("Profile")
            .foregroundStyle(Color.tintColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            AuthService.shared.signout()
                        }
                    } label: {
                        Image(systemName: "door.right.hand.open")
                            .foregroundStyle(Color.tintColor)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USER[1])
}
