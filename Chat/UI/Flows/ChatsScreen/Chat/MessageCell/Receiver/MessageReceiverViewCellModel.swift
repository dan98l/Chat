//
//  MessageReceiverViewCellModel.swift
//  Chat
//
//  Created by Daniil G on 31.03.2021.
//

import Foundation

class MessageReceiverViewCellModel {
    
    // MARK: - Properties
    
    var message: String
    var date: String
    
    // MARK: - Functions
    
    init(message: String, date: String) {
        self.message = message
        self.date = date
    }
}
