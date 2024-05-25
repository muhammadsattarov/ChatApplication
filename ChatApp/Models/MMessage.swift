//
//  MMessage.swift
//  ChatApp
//
//  Created by user on 21/05/24.
//

import Foundation
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {
        
    let content: String
    var sender: MessageKit.SenderType
    var sentDate: Date
    let id: String?
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKit.MessageKind {
       // return .text(content)
        if let image = image {
            let mediaItem = ImageItem(placeholderImage: image, size: image.size)
            return .photo(mediaItem)
        } else {
            return .text(content)
        }
    }

    var image: UIImage? = nil
    var downloadUrl: URL? = nil
    
    init(user: MUser, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    init(user: MUser, image: UIImage) {
        sender = Sender(senderId: user.id, displayName: user.username)
        self.image = image
        content = ""
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderId"] as? String else { return nil }
        guard let senderName = data["senderUsername"] as? String else { return nil }
    //    guard let content = data["content"] as? String else { return nil }

        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        sender = Sender(senderId: senderId, displayName: senderName)
        
        if let content = data["content"] as? String {
            self.content = content
            downloadUrl = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadUrl = url
            self.content = ""
        } else {
            return nil
        }
                
    }
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderId": sender.senderId,
            "senderUsername": sender.displayName,
        ]
        if let url = downloadUrl {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}


struct ImageItem: MediaItem {
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
}
