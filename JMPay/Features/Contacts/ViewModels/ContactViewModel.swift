//
//  ContactViewModel.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class ContactViewModel {
    
    // MARK: - Constants
    
    private let model: Contact
    
    // MARK: - Init
    
    init(_ model: Contact) {
        self.model = model
    }
    
    // MARK: - Variables to view
    
    var id: Int {
        return model.id ?? 0
    }
    
    var name: String {
        return model.name ?? ""
    }
    
    var username: String {
        return model.username ?? ""
    }
    
    var image: String? {
        return model.image
    }
    
}
