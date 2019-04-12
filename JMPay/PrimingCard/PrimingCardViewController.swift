//
//  PrimingCardViewController.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class PrimingCardViewController: UIViewController {
    
    // MARK: - Variables
    
    var viewModel: TransactionViewModel?
    
    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CreditCardTableViewController {
            destination.viewModel = self.viewModel
        }
    }
    
}
