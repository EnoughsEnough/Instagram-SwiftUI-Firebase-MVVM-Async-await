//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 28.11.2023.
//

import PhotosUI
import Firebase
import SwiftUI
import FirebaseFirestore

@MainActor
class EditProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var name = ""
    @Published var bio = ""
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                await loadImage(fromItem: selectedImage)
            }
        }
    }
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.name = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        // update profile image if changed
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        // update name if changed
        if !name.isEmpty && user.fullname != name {
            data["fullname"] = name
        }
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
            try await AuthService.shared.loadUserData()
            self.user = try await UserService.fetchUser(withUid: user.id)
        }
        
        
    }
}
