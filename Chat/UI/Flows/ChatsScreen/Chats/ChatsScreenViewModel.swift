//
//  ChatsScreenViewModel.swift
//  Chat
//
//  Created by Daniil G on 23.03.2021.
//

import Foundation

protocol ChatsScreenViewModelDelegate: class {
    func didTapAddButton(_ viewModel: ChatsScreenViewModel)
}

class ChatsScreenViewModel {
    
    // MARK: - Properties
    
    weak var delegate: ChatsScreenViewModelDelegate?
    
    private var chats: [ChatModel] = []
    var database: RealmDatabaseService
    
    // MARK: - Functions
    
    init(database: RealmDatabaseService) {
        self.database = database
    }
    
    func setupTableView() {
        
        database.loadChats(completion: { error in
            print(error ?? "error get chats")
        })
        chats = database.chats()
    }
    
    func isHiddenLabel() -> Bool {
        if chats.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    func chatsCount() -> Int {
        return chats.count
    }
    
    func didTapAddButton() {
        delegate?.didTapAddButton(self)
    }
}
