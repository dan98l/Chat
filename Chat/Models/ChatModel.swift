//
//  ChatModel.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import Foundation
import RealmSwift

@objcMembers
class ChatModel: Object {
    dynamic var id = Int()
    dynamic var messages = List<MessageModel>()
}
