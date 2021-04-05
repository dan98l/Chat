//
//  HomeScreenViewModel.swift
//  Chat
//
//  Created by Daniil G on 22.03.2021.
//

import Foundation

protocol HomeScreenViewModelDelegate: class {
    func didTapSignInButton(_ viewModel: HomeScreenViewModel)
}

class HomeScreenViewModel {
    
    // MARK: - Properties
    
    weak var delegate: HomeScreenViewModelDelegate?
    
    // MARK: - Functions
    
    func didTapSignInButton() {
        delegate?.didTapSignInButton(self)
    }
}
