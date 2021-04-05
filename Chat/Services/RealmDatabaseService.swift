//
//  RealmDatabaseService.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import Foundation
import RealmSwift

protocol ChatService {
    func chats() -> [ChatModel]
    func save(chat: ChatModel)
    func save(message: MessageModel, idChat: Int)
    func loadChats(completion: @escaping (Error?) -> Void)
    func idForChat() -> Int
}

class RealmDatabaseService {
    
    // MARK: - Properties
    
    private static let sharedInstance = RealmDatabaseService()
    static func shared() -> RealmDatabaseService { sharedInstance }
        
    private let realm: Realm
    
    private var chatsList: [ChatModel] = []
    
    // MARK: - Functions
    
    private init() {
        realm = try! Realm()
    }
    
}

extension RealmDatabaseService: ChatService {
    
    func chats() -> [ChatModel] {
        chatsList
    }
    
    func save(chat: ChatModel) {
        try! realm.write {
            realm.add(chat)
        }
    }
    
    func save(message: MessageModel, idChat: Int) {
        let chats = realm.objects(ChatModel.self)
        let chat = chats.filter("id == \(idChat)")
        
        try! realm.write {
            chat.elements[0].messages.append(message)
            print(message)
        }
    }
    
    func loadChats(completion: @escaping (Error?) -> Void) {
        let chats = realm.objects(ChatModel.self)
        chatsList = Array(chats)
    }
    
    func idForChat() -> Int {
        loadChats { (error) in
            print(error ?? "Error get chats")
        }
        guard let last = chatsList.last else { return 0 }
        return last.id + 1
    }
    
}
