//
//  UIBarButtonItem+UIImage.swift
//  Chat
//
//  Created by Daniil G on 01.04.2021.
//

import UIKit

extension UIBarButtonItem {
    convenience init(title: String, image: UIImage?, target: Any, selector: Selector) {
        let button = UIButton(type: .system)
        let imageSize = CGSize(width: 22, height: 22)
        if let image = image {
            button.setImage(image.scale(to: imageSize), for: .normal)
        }
        
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.sizeToFit()

        self.init(customView: button)
    }
}

extension UIImage {
    func scale(to size: CGSize) -> UIImage {
        if self.size != size {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            self.draw(in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        } else { return self }
    }
}
