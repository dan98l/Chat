//
//  Message.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import Foundation
import RealmSwift

enum User {
    case sender
    case receiver
}

@objcMembers
class MessageModel: Object {
    dynamic var date: String = ""
    dynamic var user: User = .sender
    dynamic var message: String = ""
}
