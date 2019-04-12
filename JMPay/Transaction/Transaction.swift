//
//  Transaction.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class Transaction: Encodable {
    
    var cardNumber: String?
    var cvv: String?
    var value: Double?
    var expiryDate: String?
    var destUserId: Int?
    
    enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case cvv
        case value
        case expiryDate = "expiry_date"
        case destUserId = "destination_user_id"
    }
    
    init() { }
}
