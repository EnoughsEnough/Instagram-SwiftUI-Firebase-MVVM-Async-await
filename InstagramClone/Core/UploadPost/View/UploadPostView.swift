//
//  UploadPostView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack {
            // action tool bar
            HStack {
                Button {
                    clearPostDataAndReturnToFeed()
                } label: {
                    Text("Cancel")
                }
                .opacity(viewModel.isLoading ? 0.7 : 1.0)
                .disabled(viewModel.isLoading)
                
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try? await viewModel.uploadPost(caption: caption)
                        clearPostDataAndReturnToFeed()
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
                .opacity(viewModel.isLoading ? 0.7 : 1.0)
                .disabled(viewModel.isLoading)
            }
            .padding(.horizontal)
            
            // post image and caption
            HStack(spacing: 8) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .onTapGesture {
                            imagePickerPresented.toggle()
                        }
                }
                
                TextField("Enter your caption...", text: $caption, axis: .vertical)
                    .autocorrectionDisabled()
            }
            .padding()
            
            Spacer()
            
        }
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
    }
    
    func clearPostDataAndReturnToFeed() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
