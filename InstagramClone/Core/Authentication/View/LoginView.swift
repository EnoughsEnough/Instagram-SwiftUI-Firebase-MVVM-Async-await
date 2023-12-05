//
//  LoginView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                // logo image
                Image("instagramLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                
                // text fields
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(IGTextFieldModifier())
                }
                
                Button {
                    print("Show forgot password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task {
                        do {
                            try await viewModel.signIn()

                        } catch {
                            showAlert.toggle()
                        }
                    }
                } label: {
                    Text("Login")
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
                
                Divider()
                
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                }
                .padding(.vertical, 16)

            }
        }
        .onReceive(viewModel.$error) { error in
                    if let error = error {
                        showAlert = true
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.error ?? "")
                    )
                }
                   
    }
}

extension LoginView: AuthFormProtocol {
    var formIsValid: Bool {
        !viewModel.email.isEmpty &&
        viewModel.email.contains("@") &&
        viewModel.email.contains(".") &&
        !viewModel.password.isEmpty &&
        viewModel.password.count > 5
        
    }
    
    
}

#Preview {
    LoginView()
}
