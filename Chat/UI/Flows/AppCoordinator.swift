//
//  AppCoordinator.swift
//  Chat
//
//  Created by Daniil G on 22.03.2021.
//

import UIKit

class AppCoordinator: HomeCoordinatorlDelegate {
    
    // MARK: - Properties
    
    private let navigationController = UINavigationController()
    private let window: UIWindow
    
    private let database = RealmDatabaseService.shared()
    
    private let homeCoordinator: HomeCoordinator
    private var chatsCoordinator: ChatsCoordinator?
    
    // MARK: - Functions
    
    init(window: UIWindow) {
        self.window = window
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.delegate = self
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showHomeScreen()
    }
    
    private func showHomeScreen() {
        homeCoordinator.start()
    }
    
    func signIn() {
        showChatsScreen()
    }
    
    private func showChatsScreen() {
        chatsCoordinator = ChatsCoordinator(navigationController: navigationController, database: database)
        
        if let chatsCoordinator = chatsCoordinator {
            chatsCoordinator.start()
        }
    }
}
