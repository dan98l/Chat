//
//  AutoLoadable.swift
//  Chat
//
//  Created by Daniil G on 24.03.2021.
//

import UIKit

protocol AutoLoadable {
    static func instantiate(from storyboardName: String) -> Self
}

extension AutoLoadable where Self: UIViewController {
    static func instantiate(from storyboardName: String) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
