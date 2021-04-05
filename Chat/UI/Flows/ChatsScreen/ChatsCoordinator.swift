//
//  ChatsCoordinator.swift
//  Chat
//
//  Created by Daniil G on 23.03.2021.
//

import UIKit

class ChatsCoordinator: ChatsScreenViewModelDelegate, ChatScreenViewModelDelegate {

    // MARK: - Properties
    
    private let navigationController: UINavigationController
    private let database: RealmDatabaseService
    private var chatScreenViewController: ChatScreenViewController?
    private var chatsScreenViewController: ChatsScreenViewController?
    
    // MARK: - Functions
    
    init(navigationController: UINavigationController, database: RealmDatabaseService) {
        self.navigationController = navigationController
        self.database = database
    }
    
    func start() {
        showChatsScreen()
    }
        
    private func showChatsScreen() {
        let chatsScreenViewModel = ChatsScreenViewModel(database: database)
        
        chatsScreenViewController = ChatsScreenViewController.instantiate(from: "ChatsScreen")
        guard let chatsScreenViewController = chatsScreenViewController else { return }
        chatsScreenViewController.viewModel = chatsScreenViewModel
        chatsScreenViewModel.database = database
        chatsScreenViewModel.delegate = self
        
        navigationController.pushViewController(chatsScreenViewController, animated: true)
    }
    
    func didTapAddButton(_ viewModel: ChatsScreenViewModel) {
        showChatScreen()
    }
    
    func dissmis(_ viewModel: ChatScreenViewModel) {
        guard let chatScreenViewController = chatScreenViewController,
              let chatsScreenViewController = chatsScreenViewController else { return }
        chatScreenViewController.dismiss(animated: true) {
            self.navigationController.popToViewController(chatsScreenViewController, animated: true)
        }
    }
    
    private func showChatScreen() {
        let chatScreenViewModel = ChatScreenViewModel(database: database)
        
        chatScreenViewController = ChatScreenViewController.instantiate(from: "ChatsScreen")
        
        guard let chatScreenViewController = chatScreenViewController else { return }
        chatScreenViewController.viewModel = chatScreenViewModel
        chatScreenViewModel.delegate = self
        navigationController.pushViewController(chatScreenViewController, animated: true)
    }
}
