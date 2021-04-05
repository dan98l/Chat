//
//  ChatTableViewCell.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var background: UIView! {
        didSet {
            background.backgroundColor = .black
            background.layer.cornerRadius = 8
        }
    }
    
    // MARK: - Properties
    
    var viewModel: ChatTableViewCellModel?
}
