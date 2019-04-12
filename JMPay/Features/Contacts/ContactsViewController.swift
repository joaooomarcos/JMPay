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
    var receipt: ReceiptViewModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: CustomSearchBarView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation(preferLarge: true, bartintColor: UIColor(hex: "#1D1E20"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.verifyForReceipt()
    }
    
    // MARK: - Privates
    
    private func setup() {
        self.searchBarView.delegate = self
    }
    
    private func loadData() {
        self.activityIndicator.startAnimating()
        self.viewModel.load { success, _ in
            self.activityIndicator.stopAnimating()
            if success {
                self.tableView.reloadData(animated: true)
            } else {
                self.showAlert(title: "Erro", message: "Problemas ao carregar", firstButtonTitle: "Tentar novamente", firstButtonAction: { _ in
                    self.loadData()
                })
            }
        }
    }
    
    private func filter(text: String) {
        self.viewModel.filter(text: text) {
            self.tableView.reloadData(animated: true)
        }
    }
    
    private func verifyForReceipt() {
        if receipt != nil {
            self.performSegue(withIdentifier: "presentReceipt", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PrimingCardViewController, let contact = sender as? ContactViewModel {
            let newViewModel = TransactionViewModel()
            newViewModel.contact = contact
            destination.viewModel = newViewModel
        } else if let destination = segue.destination as? ReceiptViewController {
            destination.viewModel = self.receipt
            self.receipt = nil
        }
    }
}

extension UITableView {
    func reloadData(animated: Bool = false) {
        if animated {
            UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
        } else {
            self.reloadData()
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
        self.performSegue(withIdentifier: "showPrimingCardController", sender: viewModel.element(for: indexPath.row))
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
