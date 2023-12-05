//
//  CommentView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import SwiftUI

struct CommentView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CommentViewModel
    let post: Post
    
    init(post: Post) {
        self.post = post
        self._viewModel = StateObject(wrappedValue: CommentViewModel(post: post))
    }
    
    
    var body: some View {
        VStack{
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.0)
                        .padding()
                } else {
                    ForEach(viewModel.comments) { comment in
                        CommentCellView(comment: comment)
                            .padding(.vertical)
                        
                        ZStack(alignment: .center) {
                            Divider()
                                .frame(width: 300, height: 2)
                                .foregroundStyle(Color.tintColor)
                        }
                        
                    }
                }
            }
            .defaultScrollAnchor(.bottom)
            
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $viewModel.text, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                    .disabled(viewModel.isLoading)
                    .autocorrectionDisabled()
                
                Button {
                    Task {
                        try await viewModel.sendComment()
                    }
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                }
                .opacity(viewModel.isLoading ? 0.7 : 1.0)
                .disabled(viewModel.isLoading || viewModel.text.isEmpty)

            }
            .padding(.horizontal)
        }
        .navigationTitle("Comments")
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
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

#Preview {
    CommentView(post: Post.MOCK_POSTS[1])
}
