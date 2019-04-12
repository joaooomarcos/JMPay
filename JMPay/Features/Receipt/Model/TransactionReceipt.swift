//
//  TransactionReceipt.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class TransactionReceipt: Decodable {
    
    var id: Int?
    var timestamp: Double?
    var value: Double?
    var destUser: Contact?
    var success: Bool?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case value
        case destUser = "destination_user"
        case success
        case status
    }
}
