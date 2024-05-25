//
//  Mchat.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import Foundation
import FirebaseFirestore

struct MChat: Hashable, Decodable {
    var friendUserName: String
    var friendImageStringUrl: String
    var lastMessage: String
    var friendId: String
    
    init(friendUserName: String, friendImageStringUrl: String, lastMessage: String, friendId: String) {
        self.friendUserName = friendUserName
        self.friendImageStringUrl = friendImageStringUrl
        self.lastMessage = lastMessage
        self.friendId = friendId
    }
    
    var representation: [String: Any] {
        var rep = ["friendUserName" : friendUserName]
        rep["friendImageStringUrl"] = friendImageStringUrl
        rep["lastMessage"] = lastMessage
        rep["friendId"] = friendId
        return rep
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUserName = data["friendUserName"] as? String,
              let friendImageStringUrl = data["friendImageStringUrl"] as? String,
              let lastMessage = data["lastMessage"] as? String,
              let friendId = data["friendId"] as? String else {
            return nil
        }
        self.friendUserName = friendUserName
        self.friendImageStringUrl = friendImageStringUrl
        self.lastMessage = lastMessage
        self.friendId = friendId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
