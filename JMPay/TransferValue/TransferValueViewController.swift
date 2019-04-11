//
//  TransferValueViewController.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class TransferValueViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var userImage: JMImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var creditCardLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func editButtonTapped() {
        
    }
    
    @IBAction func payButtonTapped() {
        
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
    }
}
