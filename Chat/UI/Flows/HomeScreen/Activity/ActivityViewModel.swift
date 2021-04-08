//
//  ActivityViewModel.swift
//  Chat
//
//  Created by Daniil G on 08.04.2021.
//

import Foundation

protocol ActivityViewModelDelegate: class {
    func dissmisActivityView(_ viewModel: ActivityViewModel)
}

class ActivityViewModel {
    
    // MARK: - Properties
    
    weak var delegate: ActivityViewModelDelegate?
    
    // MARK: - Functions
    
    func stopAnimation() {
        delegate?.dissmisActivityView(self)
    }
}

