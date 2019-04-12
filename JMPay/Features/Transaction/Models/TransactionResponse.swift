//
//  Transaction.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class TransactionResponse: Decodable {
    
    var receipt: TransactionReceipt?
    
    enum CodingKeys: String, CodingKey {
        case receipt = "transaction"
    }
}
