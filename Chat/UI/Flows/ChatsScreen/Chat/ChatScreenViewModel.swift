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
    
    var changeСhatIndex: Int? {
        didSet {
            guard let index = changeСhatIndex else { return }
            guard let chat = database.chat(index: index) else { return }
            messages.append(contentsOf: chat.messages)
        }
    }
    
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
            let messageModel = MessageModel(date: Date(), user: randomUser(), message: message)
            if changeСhatIndex == nil {
                messages.append(messageModel)
            } else {
                messages.append(messageModel)
                database.save(message: messageModel, idChat: changeСhatIndex!)
            }
            completion()
        }
    }
    
    func didTapComebackButton() {
        if messages.count > 0 && changeСhatIndex == nil {
            save()
        } else {
            delegate?.dissmis(self)
        }
    }
    
    func tableCellViewModelSender(index: Int) -> MessageSenderViewCellModel {
        MessageSenderViewCellModel(message: messages[index].message, date: time(index: index))
    }
    
    func tableCellViewModelReceiver(index: Int) -> MessageReceiverViewCellModel {
        MessageReceiverViewCellModel(message: messages[index].message, date: time(index: index))
    }
    
    func user(index: Int) -> User {
        messages[index].user
    }
    
    private func save() {
        chatModel.id = database.getNewId()
        for message in messages {
            chatModel.messages.append(message)
        }
        database.save(chat: chatModel, completion: {
            self.delegate?.dissmis(self)
        })
    }
    
    private func time(index: Int) -> String {
        let time = messages[index].date
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: time as Date)
    }
    
    private func randomUser() -> User {
        Bool.random() ? User.sender : User.receiver
    }
}
