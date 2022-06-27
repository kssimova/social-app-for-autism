//
//  User.swift
//  SocialApp
//
//  Created by Kristina Simova on 21.05.22.
//

import Foundation

enum Role: String {
    case adult, child
}

class User: Codable {
    var name: String
    var familyName: String
    var emailAddress: String
    var username: String
    
    // maybe it should be UUID
    var userId: String
    
    // should be enum
    var role: String
    
    var childrenIds: [String] = [String]()
    
    init(name: String, familyName: String, email: String, username: String, userId: String, role: String) {
        self.name = name
        self.familyName = familyName
        self.emailAddress = email
        self.username = username
        self.userId = userId
        self.role = role
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case familyName
        case emailAddress = "email"
        case username
        case userId = "id"
        case role
        case childrenIds
    }
    
    func setUserId(userId: String) {
        self.userId = userId
    }
}

