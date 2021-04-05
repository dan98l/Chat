//
//  HomeCoordinator.swift
//  Chat
//
//  Created by Daniil G on 22.03.2021.
//

import UIKit

protocol HomeCoordinatorlDelegate: class {
    func signIn()
}

class HomeCoordinator: HomeScreenViewModelDelegate {
    
    // MARK: - Properties
    
    private let navigationController: UINavigationController
    weak var delegate: HomeCoordinatorlDelegate?
    
    // MARK: - Functions
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeScreen()
    }
        
    private func showHomeScreen() {
        let homeScreenViewModel = HomeScreenViewModel()
        homeScreenViewModel.delegate = self
        
        let homeScreenViewController = HomeScreenViewController.instantiate(from: "HomeScreen")
        homeScreenViewController.viewModel = homeScreenViewModel
        
        navigationController.pushViewController(homeScreenViewController, animated: true)
    }
    
    func didTapSignInButton(_ viewModel: HomeScreenViewModel) {
        delegate?.signIn()
    }
}
