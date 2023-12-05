//
//  AuthService.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 27.11.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
        
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            try? await loadUserData()
        }
    }
    
    @MainActor
    func login(with email: String, password: String) async throws {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try? await loadUserData()
    }
    
    @MainActor
    func createUser(with email: String, password: String, username: String) async throws {
        do {
            let result = try? await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result?.user
            await uploadUserData(uid: result?.user.uid ?? "", username: username, email: email)
        } catch {
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUser = userSession?.uid else { return }
        self.currentUser = try await UserService.fetchUser(withUid: currentUser)
        print(self.currentUser?.fullname)
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
