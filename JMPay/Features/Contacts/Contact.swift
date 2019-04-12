//
//  Contact.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class Contact: Decodable {
    
    var id: Int?
    var name: String?
    var username: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case image = "img"
    }
}
