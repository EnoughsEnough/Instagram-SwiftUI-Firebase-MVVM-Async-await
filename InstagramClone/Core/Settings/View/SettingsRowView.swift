//
//  SettingsRowView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 05.12.2023.
//

import SwiftUI

struct SettingsRowView: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                
                Text(title)
                
                Spacer()
                
            }
            .padding(.horizontal)
            Divider()
                .background(Color.tintColor)
                .frame(width: 250, height: 5)
//                .padding(.top, 5)

        }
    }
}

#Preview {
    SettingsRowView(title: "", icon: "")
}
