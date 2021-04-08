//
//  ChatsScreenViewModel.swift
//  Chat
//
//  Created by Daniil G on 23.03.2021.
//

import Foundation

protocol ChatsScreenViewModelDelegate: class {
    func didTapAddButton(_ viewModel: ChatsScreenViewModel)
    func didTapTableCell(_ viewModel: ChatsScreenViewModel, index: Int)
}

class ChatsScreenViewModel {
    
    // MARK: - Properties
    
    weak var delegate: ChatsScreenViewModelDelegate?
    
    private var messages: [MessageModel] = []
    private var chats: [ChatModel] = [] {
        didSet {
            chats = chats.sorted { $0.messages.last!.date > $1.messages.last!.date }
        }
    }
    var database: RealmDatabaseService
    
    // MARK: - Functions
    
    init(database: RealmDatabaseService) {
        self.database = database
    }
    
    func setupTableView(completion: @escaping () -> Void) {
        database.loadChats(completion: { error in
            print(error ?? "error get chats")
        })
        chats = database.chats()
        completion()
    }
    
    func isHiddenLabel() -> Bool {
        if chats.count > 0 {
            return true
        } else {
            return false
        }
        
    }
    
    func chatsCount() -> Int {
        chats.count
    }
    
    func didTapAddButton() {
        delegate?.didTapAddButton(self)
    }
    
    func didTapTableCell(index: Int) {
        delegate?.didTapTableCell(self, index: chats[index].id)
    }
    
    func didSwipeDeleteCell(index: Int, completion: @escaping () -> Void) {
        database.deleteChat(index: chats[index].id, completion: {
            completion()
        })
    }
    
    func collectionCell(index: Int) -> ChatTableViewCellModel {
        if let message = chats[index].messages.last {
            return ChatTableViewCellModel(message: message.message, date: time(date: message.date))
        } else {
            return ChatTableViewCellModel()
        }
    }
    
    private func time(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date as Date)
    }
}
