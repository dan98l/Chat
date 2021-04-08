//
//  ChatTableViewCellModel.swift.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import Foundation

class ChatTableViewCellModel {
    
    // MARK: - Properties
    
    var message: String
    var date: String
    
    // MARK: - Functions
    
    init() {
        self.message = ""
        self.date = ""
    }
    
    init(message: String, date: String) {
        self.message = message
        self.date = date
    }
}
