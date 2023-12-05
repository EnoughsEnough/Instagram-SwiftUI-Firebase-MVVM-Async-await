//
//  PostGridView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @StateObject var viewModel: PostGridViewModel
    var user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimenstion: CGFloat = (UIScreen.main.bounds.width / 3) - 1

    
    var body: some View {
            LazyVGrid(columns: gridItems, spacing: 1) {
                ForEach(viewModel.posts) { post in
                    NavigationLink(destination: CurrentUserFeedView(user: user)) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimenstion, height: imageDimenstion)
                            .clipped()
                        
                    }
                }
            }
    }
}

#Preview {
    PostGridView(user: User.MOCK_USER[0])
}
