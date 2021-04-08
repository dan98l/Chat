//
//  Message.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import Foundation
import RealmSwift

enum User: String, CaseIterable {
    case sender
    case receiver
}

@objcMembers
class MessageModel: Object {
    dynamic var date: Date
    dynamic var message: String
    dynamic var userRaw = User.sender.rawValue
    dynamic var user: User {
        get {
            for user in User.allCases where userRaw == user.rawValue {
                return user
            }
            return .sender //default
        }
        set {
            userRaw = newValue.rawValue
        }
    }
    
    override init() {
        self.date = Date.init()
        self.message = ""
        self.userRaw = User.sender.rawValue
    }
    
    init(date: Date, user: User, message: String) {
        self.date = date
        self.message = message
        self.userRaw = user.rawValue
    }
}
