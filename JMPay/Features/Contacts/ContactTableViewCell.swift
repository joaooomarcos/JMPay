//
//  ContactTableViewCell.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell, ReusableView {
    
    // MARK: - Outlets

    @IBOutlet private weak var contactImage: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Setup
    
    func setup(_ viewModel: ContactViewModel) {
        self.usernameLabel.text = viewModel.username
        self.nameLabel.text = viewModel.name
        self.contactImage.setImage(with: viewModel.image)
    }
    
}
