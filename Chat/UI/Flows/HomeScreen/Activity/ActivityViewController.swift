//
//  ActivityViewController.swift
//  Chat
//
//  Created by Daniil G on 07.04.2021.
//

import UIKit

class ActivityViewController: UIViewController, AutoLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIImageView!
    
    // MARK: - Properties
    
    var viewModel: ActivityViewModel!
    private var animate = true
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        rotateImage(image: activityIndicator)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(stopAnimation), userInfo: nil, repeats: false)
    }
    
    @objc func stopAnimation() {
        self.animate = false
        self.viewModel?.stopAnimation()
    }
    
    private func rotateImage(image: UIImageView) {
        
        UIView.animate(withDuration: 1.0, animations: {
            image.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            image.transform = CGAffineTransform.identity
        }) { (completed) in
            if self.animate {
                self.rotateImage(image: image)
            }
        }
    }
}
