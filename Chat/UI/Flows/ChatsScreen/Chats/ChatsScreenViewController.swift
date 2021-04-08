//
//  ChatsScreenViewController.swift
//  Chat
//
//  Created by Daniil G on 23.03.2021.
//

import UIKit

class ChatsScreenViewController: UIViewController, AutoLoadable, TableHandler {

    // MARK: - IBOutlets
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var chatsTableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: ChatsScreenViewModel?
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        settingNavigationController()
        settingHiddenUI()
    }
    
    private func setupTableView() {
        guard let viewModel = viewModel else { return }
        viewModel.setupTableView {
            self.chatsTableView.reloadData()
        }
    }
    
    private func settingHiddenUI() {
        guard let viewModel = viewModel else { return }
        
        if viewModel.isHiddenLabel() {
            infoLabel.isHidden = true
            chatsTableView.isHidden = false
        } else {
            infoLabel.isHidden = false
            chatsTableView.isHidden = true
        }
    }
    
    private func settingNavigationController() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    @objc private func didTapAddButton() {
        guard let viewModel = viewModel else { return }
        viewModel.didTapAddButton()
    }
    
    func updateTableView() {
        setupTableView()
        settingHiddenUI()
    }
}

// MARK: - TableView DataSource, Delegate
extension ChatsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.chatsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        cell.viewModel = viewModel?.collectionCell(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.didTapTableCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (contextualAction, view, boolValue) in
            self.viewModel?.didSwipeDeleteCell(index: indexPath.row) {
                self.setupTableView()
                self.settingHiddenUI()
            }
        }
        deleteAction.image = UIImage(named: "iconDelete")?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}
