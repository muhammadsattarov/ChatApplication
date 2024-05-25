//
//  MUser.swift
//  ChatApp
//
//  Created by user on 18/05/24.
//

import Foundation
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var username: String
    var email: String
    var avatarStringURL: String
    var description: String
    var gender: String
    var id: String
    
    init(username: String, email: String, avatarStringURL: String, description: String, gender: String, id: String) { 
        self.username = username
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.gender = gender
        self.id = id
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let username = data["username"] as? String else { return nil }
        guard let email = data["email"] as? String else { return nil }
        guard let avatarStringURL = data["avatarStringURL"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let gender = data["gender"] as? String else { return nil }
        guard let id = data["uid"] as? String else { return nil }
 
        self.username = username
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.gender = gender
        self.id = id
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let username = data["username"] as? String else { return nil }
        guard let email = data["email"] as? String else { return nil }
        guard let avatarStringURL = data["avatarStringURL"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let gender = data["gender"] as? String else { return nil }
        guard let id = data["uid"] as? String else { return nil }
 
        self.username = username
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.gender = gender
        self.id = id
    }
    
    var representation: [String: Any] {
        var rep = ["username": username]
        rep["email"] = email
        rep["avatarStringURL"] = avatarStringURL
        rep["description"] = description
        rep["gender"] = gender
        rep["uid"] = id
        return rep
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
