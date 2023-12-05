//
//   ImageUploader.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 28.11.2023.
//

import FirebaseStorage
import UIKit
import Firebase

struct ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5    ) else { return nil }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
    
}
