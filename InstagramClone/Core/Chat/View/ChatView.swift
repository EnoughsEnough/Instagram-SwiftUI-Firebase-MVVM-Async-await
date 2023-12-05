//
//  ChatView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 29.11.2023.
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ChatViewModel
    @State private var imagePickerPresented = false

    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                // header
                VStack {
                    NavigationLink(destination: ProfileView(user: user)) {
                        RoundedImageView(user: user, size: .large)
                    }
                    
                    Text(user.username)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                }
                // messages
                ForEach(viewModel.messages) { message in
                    ChatMessageCell(message: message)
                }
                
            }
            .defaultScrollAnchor(.bottom)
            // messsage input view
            
                HStack {
                    if let image = viewModel.postImage {
                       image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipped()
                            .onTapGesture {
                                imagePickerPresented.toggle()
                            }
                    } else {
                        Image(systemName: "photo.artframe")
                            .foregroundStyle(Color.tintColor)
                            .imageScale(.large)
                            .onTapGesture {
                                imagePickerPresented.toggle()
                            }
                    }
                    
                    ZStack(alignment: .trailing) {
                        
                        TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                            .padding(12)
                            .padding(.trailing, 48)
                            .background(Color(.systemGroupedBackground))
                            .clipShape(Capsule())
                            .font(.subheadline)
                            .autocorrectionDisabled()
                        
                        Button {
                            Task {
                                try await viewModel.sendMessage()
                                viewModel.messageText = ""
                                viewModel.selectedImage = nil
                                viewModel.postImage = nil
                            }
                            viewModel.messageText = ""
                        } label: {
                            Text("Send")
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                        }
                        .disabled(viewModel.messageText.isEmpty && (viewModel.selectedImage == nil))
                    }
                }
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        .toolbar(.hidden, for: .tabBar)
        .padding(12)
        .navigationBarBackButtonHidden()
        .navigationTitle(user.username)
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


#Preview {
    ChatView(user: User.MOCK_USER[1])
}
