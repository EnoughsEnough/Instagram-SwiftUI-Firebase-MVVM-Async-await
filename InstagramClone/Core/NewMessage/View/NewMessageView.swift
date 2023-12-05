//
//  NewMessageView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 30.11.2023.
//

import SwiftUI

struct NewMessageView: View {
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = NewMessageViewModel()
    @Binding var selectedUser: User?
    
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
                TextField("To:", text: $searchText)
                    .autocorrectionDisabled()
                    .frame(height: 44)
                    .padding(.horizontal)
                    .background(Color(.systemGroupedBackground))
                
                Text("CONTACTS")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(filteredUsers) { user in
                    NavigationLink(destination: ChatView(user: user)) {
                        VStack {
                            HStack {
                                RoundedImageView(user: user, size: .small)
                                
                                Text(user.username)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            .padding(.leading)
                            
                            Divider()
                                .padding(.leading, 40)
                        }
                        .onTapGesture {
                            selectedUser = user
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                           Button(action: {
                              dismiss()
                           }) {
                               HStack {
                                   Image(systemName: "chevron.left")
                                       .foregroundStyle(Color.tintColor)
                               }
                           }
                       )
        }
    }
}

#Preview {
    NewMessageView(selectedUser: .constant(User.MOCK_USER[1]))
}
