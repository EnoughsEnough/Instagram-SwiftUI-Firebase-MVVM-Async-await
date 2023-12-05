//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var user: User
    
    var body: some View {
            VStack {
                // header
                ProfileHeaderView(user: user)
                
                // post grid view
                
                ScrollView {
                        PostGridView(user: user)
                }
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
            }
    }
}

#Preview {
    ProfileView(user: User.MOCK_USER[1])
}
