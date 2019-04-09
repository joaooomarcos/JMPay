//
//  ContactViewModel.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class ContactViewModel {
    
    private let model: Contact
    
    init(_ model: Contact) {
        self.model = model
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
