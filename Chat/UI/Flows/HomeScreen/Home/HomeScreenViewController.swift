//
//  HomeScreenViewController.swift
//  Chat
//
//  Created by Daniil G on 22.03.2021.
//

import UIKit

class HomeScreenViewController: UIViewController, AutoLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButton(_ sender: Any) {
        viewModel.didTapSignInButton()
    }
    
    // MARK: - Properties
    
    var viewModel: HomeScreenViewModel!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingSignInButton()
    }
    
    private func settingSignInButton() {
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
        signInButton.layer.shadowRadius = 9
        signInButton.alpha = 0.0
        
        showSignInButtonWithAnimations()
    }
    
    private func showSignInButtonWithAnimations() {
        UIView.animate(withDuration: 1.5, delay: 0.2, options: .curveEaseIn, animations: {
            self.signInButton.alpha = 1.0
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
