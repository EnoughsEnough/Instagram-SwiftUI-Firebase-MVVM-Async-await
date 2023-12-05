//
//  CreatePasswordView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI

struct CreatePasswordView: View {
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
             Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your password must be at least 6 character in length.")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            SecureField("Password", text: $viewModel.password)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CompleteSignUpView()
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
            .padding(.vertical)
            .opacity(!formIsValid ? 0.7 : 1.0)
            .disabled(!formIsValid)
            
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

extension CreatePasswordView: AuthFormProtocol {
    var formIsValid: Bool {
        !viewModel.password.isEmpty &&
        viewModel.password.count > 5
    }
    
}

#Preview {
    CreatePasswordView()
}
