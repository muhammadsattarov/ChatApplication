//
//  StorageService.swift
//  ChatApp
//
//  Created by user on 20/05/24.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class StorageService {
    
    static let shared = StorageService()
    
    let storageRef = Storage.storage().reference()
    
    private var avatarRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    private var chatsRef: StorageReference {
        return storageRef.child("chats")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    
    func upload(photo: UIImage,
                completion: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = photo.scaledToSafeUPloadSize,
              let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        avatarRef.child(currentUserId).putData(imageData, metadata: metaData) { metaData, error in
            guard let _ = metaData else {
                completion(.failure(error!))
                return
            }
            self.avatarRef.child(self.currentUserId).downloadURL { url, error in
                guard let downloadUrl = url else {
                    completion(.failure(error!))
                    return
                }
                return completion(.success(downloadUrl))
            }
        }
    }
    
    func uploadImageMessage(photo: UIImage,
                            chat: MChat,
                            completion: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = photo.scaledToSafeUPloadSize, 
                let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        let uid: String = Auth.auth().currentUser!.uid
        let chatName = [chat.friendUserName, uid].joined()
        self.chatsRef.child(chatName).child(imageName).putData(imageData, metadata: metaData) { metaData, error in
            guard let _ = metaData else {
                completion(.failure(error!))
                return
            }
            self.chatsRef.child(chatName).child(imageName).downloadURL { url, error in
                guard let downloadUrl = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadUrl))
            }
        }
    }
    
    func downloadImageData(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(UIImage(data: imageData)))
        }
    }
}
