//
//  InboxView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 01.12.2023.
//

import SwiftUI

struct InboxView: View {
    @State private var showNewMessageView = false
    @StateObject var viewModel = InboxViewModel()
    @State private var selectedUser: User?
    @State private var showChat = false
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            List {
                ActiveNowView()
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                
                ForEach(viewModel.recentMessages) { message in
                    ZStack {
                        NavigationLink(destination: ChatView(user: message.user!)) {
                            EmptyView()
                        }.opacity(0.0)
                        
                        InboxRowView(message: message)

                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationDestination(isPresented: $showChat, destination: {
            if let user = selectedUser {
                ChatView(user: user)
            }
        })
        .toolbar(.hidden, for: .tabBar)
        .onChange(of: selectedUser) { newValue in
            showChat = newValue != nil
        }
        .fullScreenCover(isPresented: $showNewMessageView, content: {
            NewMessageView(selectedUser: $selectedUser)
        })
        .navigationBarBackButtonHidden()
        .navigationTitle("Messages")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showNewMessageView.toggle()
                    selectedUser = nil
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
