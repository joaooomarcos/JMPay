//
//  ContactsTableViewController.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    // MARK: - Variables
    
    private let viewModel: ContactsViewModel
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: CustomSearchBarView!
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = ContactsViewModel()
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.loadData()
    }
    
    // MARK: - Privates
    
    private func setup() {
        self.searchBarView.delegate = self
    }
    
    private func loadData() {
        self.viewModel.load { success, error in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    private func filter(text: String) {
        self.viewModel.filter(text: text) {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table View Data Source

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfElements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let viewModel = self.viewModel.element(for: indexPath.row)
        cell.setup(viewModel)
        return cell
    }
}

// MARK: - Table View Delegate

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPrimingCardController", sender: nil)
    }
}

extension ContactsViewController: CustomSearchBarDelegate {
    func customSearchDidChange(_ customSearch: CustomSearchBarView, text: String) {
        self.filter(text: text)
    }
    
    func customSearchDidReturn(_ customSearch: CustomSearchBarView, text: String) {
        self.filter(text: text)
    }
}
