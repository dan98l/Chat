//
//  MessageSenderViewCell.swift
//  Chat
//
//  Created by Daniil G on 31.03.2021.
//

import UIKit

class MessageSenderViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var date: UILabel!
    
    // MARK: - Properties
    
    var viewModel: MessageSenderViewCellModel? {
        didSet {
            guard let viewModel = viewModel else {
                self.message.text = ""
                self.date.text = ""
                return
            }
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
