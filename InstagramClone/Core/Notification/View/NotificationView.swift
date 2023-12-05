//
//  NotificationView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 03.12.2023.
//

import SwiftUI

struct NotificationView: View {
    let user: User
    @StateObject private var viewModel: NotificationViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: NotificationViewModel(user: user))
    }
    
    var body: some View {
            if viewModel.isLoading {
                ProgressView()
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2.0)
                    .padding()
            } else if !viewModel.isLoading && !viewModel.notifications.isEmpty {
                VStack {
                    Text("Notification")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    ScrollView {
                        ForEach(viewModel.notifications) { notification in
                            NotificationRowView(notification: notification)
                                .padding(.vertical)
                        }
                    }
                    
                    Spacer()
                }
            } else {
                Text("There is no notifications for now.")
                    .font(.title3)
                    .fontWeight(.semibold)
                
            }
    }
    
}

#Preview {
    NotificationView(user: User.MOCK_USER[1])
}
