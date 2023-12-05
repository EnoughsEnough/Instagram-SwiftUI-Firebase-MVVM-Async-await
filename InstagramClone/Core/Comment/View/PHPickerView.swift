//
//  PHPickerView.swift
//  InstagramClone
//
//  Created by Mark Cherenov on 05.12.2023.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var selectedImages: [PhotosPickerItem]?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // Установка лимита на выбор нескольких изображений
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages?.removeAll()
            
            for image in results {
                if image.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    image.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                        if let error = error {
                            print("Ошибка загрузки изображения: \(error.localizedDescription)")
                        } else if let image = selectedImage as? PhotosPickerItem {
                            DispatchQueue.main.async {
                                self.parent.selectedImages?.append(image)
                            }
                        }
                    }
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
