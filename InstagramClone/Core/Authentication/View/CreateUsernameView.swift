//
//  CreateUsernameView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI

struct CreateUsernameView: View {
    @State private var username = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
             Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Username", text: $viewModel.username)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreatePasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(.white)
            }
            .opacity(!formIsValid ? 0.7 : 1.0)
            .disabled(!formIsValid)
            .padding(.vertical)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

extension CreateUsernameView: AuthFormProtocol {
    var formIsValid: Bool {
        !viewModel.username.isEmpty &&
        viewModel.username.count > 5
    }
    
}


#Preview {
    CreateUsernameView()
}
