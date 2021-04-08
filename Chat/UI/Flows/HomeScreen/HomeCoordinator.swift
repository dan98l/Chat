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

class HomeCoordinator: HomeScreenViewModelDelegate, ActivityViewModelDelegate {
    
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
        
        showActivityScreen()
    }
    
    private func showActivityScreen() {
        let activityScreenViewModel = ActivityViewModel()
        activityScreenViewModel.delegate = self
        
        let activityScreenViewController = ActivityViewController.instantiate(from: "HomeScreen")
        activityScreenViewController.viewModel = activityScreenViewModel
        
        navigationController.present(activityScreenViewController, animated: true, completion: nil)
    }
    
    func dissmisActivityView(_ viewModel: ActivityViewModel) {
        navigationController.dismiss(animated: true) {
            self.delegate?.signIn()
        }
    }
    
}
