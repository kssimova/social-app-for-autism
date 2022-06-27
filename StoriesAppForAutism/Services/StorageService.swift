//
//  StorageService.swift
//  StoriesAppForAutism
//
//  Created by Kristina Simova on 25.06.22.
//

import UIKit
import FirebaseStorage

class StorageService {
    // Create singleton instance
    static let shared = StorageService()
    
    let storage = Storage.storage()
    var storageReference: StorageReference!
    
    private init() {
        
        // Create a storage reference
        storageReference = storage.reference()
    }
    
    func uploadAudioFiles(pages: [Page], completion: @escaping (Bool, URL?) -> Void) {
        for page in pages {
            // Data in memory
            guard let data = page.audioData else { return }
            
            // Create a reference to the file you want to upload
            let audioFileRef = storageReference.child("audioFiles/\(page.audioUUID).m4a")
            
            // Upload the file to the path "audioFiles/UUID.m4aцр"
            let uploadTask = audioFileRef.putData(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    completion(false, nil)
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                
                // You can also access to download URL after upload.
                audioFileRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        completion(false, nil)
                        return
                    }
                    
                    completion(true, downloadURL)
                    page.audioDownloadURL = downloadURL
                }
            }
        }
    }
    
    func uploadImage(folder: String, image: UIImage?, completion: @escaping (Bool, URL?) -> Void) {
        // Data in memory
        guard let data = image?.jpegData(compressionQuality: 0.75) else {
            completion(false, nil)
            return
        }
        
        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Create a reference to the file to upload
        let imageFileRef = storageReference.child("\(folder)/\(UUID().uuidString).jpeg")
        
        // Upload the file to the path "folder/imageName.jpeg"
        let uploadTask = imageFileRef.putData(data, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                completion(false, nil)
                return
            }
            
            // You can also access to download URL after upload.
            imageFileRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    completion(false, nil)
                    return
                }
                
                completion(true, downloadURL)
            }
        }
        
    }
}
