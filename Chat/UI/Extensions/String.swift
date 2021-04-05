//
//  String.swift
//  Chat
//
//  Created by Daniil G on 31.03.2021.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
