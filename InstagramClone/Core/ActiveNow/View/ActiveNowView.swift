//
//  ActiveNowView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 01.12.2023.
//

import SwiftUI

struct ActiveNowView: View {
    @StateObject var viewModel = ActiveNowViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                ForEach(viewModel.users) { user in
                    NavigationLink(destination: ChatView(user: user)) {
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                RoundedImageView(user: user, size: .medium)
                                
                                ZStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 18, height: 18)
                                    
                                    Circle()
                                        .fill(Color(.systemGreen))
                                        .frame(width: 12, height: 12)
                                }
                            }
                            
                            Text(user.username)
                                .font(.subheadline)
                                .foregroundStyle(Color.tintColor)
                                .frame(maxWidth: 60)
                        }
                        
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ActiveNowView()
}
