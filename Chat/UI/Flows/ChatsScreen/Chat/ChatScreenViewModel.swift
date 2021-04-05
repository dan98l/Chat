//
//  ChatScreenViewModel.swift
//  Chat
//
//  Created by Daniil G on 30.03.2021.
//

import Foundation

protocol ChatScreenViewModelDelegate: class {
    func dissmis(_ viewModel: ChatScreenViewModel)
}

class ChatScreenViewModel {
    
    // MARK: - Properties
    
    var database: RealmDatabaseService
    weak var delegate: ChatScreenViewModelDelegate?
    
    private let chatModel = ChatModel()
    private var messages = [MessageModel]()
    
    // MARK: - Functions
    
    init(database: RealmDatabaseService) {
        self.database = database
    }
    
    func messagesCount() -> Int {
        messages.count
    }
    
    func didTapSendMessageButton(message: String?, completion: @escaping () -> Void) {
        guard let message = message else { return }
        if !message.isEmpty {
            let messageModel = MessageModel()
            messageModel.date = time()
            messageModel.message = message
            messageModel.user = randomUser()
            messages.append(messageModel)
            completion()
        }
    }
    
    func didTapComebackButton() {
        if messages.count > 0 {
            save()
        } else {
            delegate?.dissmis(self)
        }
    }
    
    func tableCellViewModelSender(index: Int) -> MessageSenderViewCellModel {
        MessageSenderViewCellModel(message: messages[index].message, date: messages[index].date)
    }
    
    func tableCellViewModelReceiver(index: Int) -> MessageReceiverViewCellModel {
        MessageReceiverViewCellModel(message: messages[index].message, date: messages[index].date)
    }
    
    func user(index: Int) -> User {
        messages[index].user
    }
    
    private func save() {
        chatModel.id =  database.idForChat()
        for message in messages {
            chatModel.messages.append(message)
        }
        database.save(chat: chatModel)
        delegate?.dissmis(self)
    }
    
    private func time() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time as Date)
    }
    
    private func randomUser() -> User {
        if Bool.random() {
            return User.sender
        } else {
            return User.receiver
        }
    }
}

/*
 let time = NSDate()
 let formatter = DateFormatter()
 formatter.dateFormat = "HH:mm"
 let formatteddate = formatter.string(from: time as Date)
 print("\(formatteddate)")
 */
