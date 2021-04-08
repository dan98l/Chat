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
    func chat(index: Int) -> ChatModel?
    func save(chat: ChatModel, completion: @escaping () -> Void)
    func save(message: MessageModel, idChat: Int)
    func loadChats(completion: @escaping (Error?) -> Void)
    func getNewId() -> Int
    func deleteChat(index: Int, completion: @escaping () -> Void)
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
    func deleteChat(index: Int, completion: @escaping () -> Void) {

        try! realm.write {
            realm.delete( realm.objects(ChatModel.self).filter("id == \(index)"))
        }
        
        completion()
    }
    
    func chat(index: Int) -> ChatModel? {
        let chat = chatsList.filter{$0.id == index}
        return chat.first ?? nil
    }
    
    func chats() -> [ChatModel] {
        chatsList
    }
    
    func save(chat: ChatModel, completion: @escaping () -> Void) {
        try! realm.write {
            realm.add(chat)
            completion()
        }
    }
    
    func save(message: MessageModel, idChat: Int) {
        let chats = realm.objects(ChatModel.self)
        let chat = chats.filter("id == \(idChat)")
        
        try! realm.write {
            chat.elements[0].messages.append(message)
        }
    }
    
    func loadChats(completion: @escaping (Error?) -> Void) {
        let chats = realm.objects(ChatModel.self)
        chatsList = Array(chats)
    }
    
    func getNewId() -> Int {
        loadChats { (error) in
            print(error ?? "Error get chats")
        }
        guard let last = chatsList.last else { return 0 }
        return last.id + 1
    }
    
}
