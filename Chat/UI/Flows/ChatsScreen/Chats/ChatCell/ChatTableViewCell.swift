//
//  ChatTableViewCell.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var background: UIView! {
        didSet {
            background.backgroundColor = .black
            background.layer.cornerRadius = 8
        }
    }
    
    // MARK: - Properties
    
    var viewModel: ChatTableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.message.text = viewModel.message
            self.date.text = viewModel.date
        }
    }
    
    // MARK: - Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
}
