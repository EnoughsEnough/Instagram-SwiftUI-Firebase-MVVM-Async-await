//
//  UserListView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import SwiftUI

struct UserListView: View {
    let user: User
    
    var body: some View {
        HStack {
            RoundedImageView(user: user, size: .xSmall)
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.tintColor)
                
                if let fullname = user.fullname {
                    Text(fullname)
                        .foregroundStyle(Color.tintColor)
                }
                
            }
            .font(.footnote)
            
            Spacer()

        }
        .foregroundStyle(.black)
        .padding(.horizontal)
    }
}

#Preview {
    UserListView(user: User.MOCK_USER[1])
}
