//
//  ChatScreenViewController.swift
//  Chat
//
//  Created by Daniil G on 30.03.2021.
//

import UIKit

class ChatScreenViewController: UIViewController, AutoLoadable {
    // MARK: - IBOutlets
    
    @IBOutlet weak var messageCollectionView: UICollectionView!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var textFieldAndButton: UIScrollView!
    
    @IBAction func sendMessageButton(_ sender: Any) {
        viewModel?.didTapSendMessageButton(message: message.text, completion: {
            self.scrollToBottom()
            self.message.text = ""
            self.messageCollectionView.reloadData()
        })
    }
    
    // MARK: - Properties
    
    var viewModel: ChatScreenViewModel?
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigationController()
        initCell()
        swipeDownSetting()
        settingkeyboardShow()
    }
    
    private func settingNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Назад", image: UIImage(systemName: "chevron.backward"), target: self, selector: #selector(comeback))
    }
    
    private func initCell() {
        messageCollectionView.register(UINib(nibName: "MessageSenderCell", bundle: nil), forCellWithReuseIdentifier: "MessageSenderCell")
        
        messageCollectionView.register(UINib(nibName: "MessageReceiverCell", bundle: nil), forCellWithReuseIdentifier: "MessageReceiverCell")
    }
    
    private func swipeDownSetting() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    @objc private func comeback() {
        viewModel?.didTapComebackButton()
    }
    
    @objc private func hideKeyboardOnSwipeDown() {
        view.endEditing(true)
    }
    
    private func settingkeyboardShow() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    func scrollToBottom() {
        let bottomOffset = CGPoint( x: 0,
                                    y: messageCollectionView.contentSize.height
                                    - messageCollectionView.frame.size.height
                                    + textFieldAndButton.frame.size.height )
        self.messageCollectionView.setContentOffset(bottomOffset, animated: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - CollectionView DataSource, Delegate
extension ChatScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.messagesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel?.user(index: indexPath.row) {
        case .sender:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageSenderCell", for: indexPath) as! MessageSenderViewCell
            cell.viewModel = viewModel?.tableCellViewModelSender(index: indexPath.row)
            return cell
        case .receiver:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageReceiverCell", for: indexPath) as! MessageReceiverViewCell
            cell.viewModel = viewModel?.tableCellViewModelReceiver(index: indexPath.row)
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
}

// MARK: - CollectionView UICollectionViewDelegateFlowLayout
extension ChatScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100.0)
        
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ChatScreenViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
