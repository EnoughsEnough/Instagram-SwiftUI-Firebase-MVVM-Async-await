//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 28.11.2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedImage: PhotosPickerItem?
    @StateObject private var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            // toolbar
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try? await viewModel.updateUserData()
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
                Divider()
            }
            
            // edit profile info
            
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                    } else {
                        RoundedImageView(user: viewModel.user, size: .large)

                    }
                     
                    Text("Edit Profile picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()

                }
            }
            .padding(.vertical, 8)
            
            // edit profile bio
            
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name ", text: $viewModel.name)
                
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $viewModel.bio)
            }
            
            Spacer()
        }
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USER[1])
}
