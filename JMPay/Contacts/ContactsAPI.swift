//
//  ContactsAPI.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class ContactsAPI {
    func getContactList(completion: @escaping (Result<[Contact]>) -> Void) {
        WebConnection.request(endpoint: ContactsEndpoint.getList, completion: completion)
    }
}

enum ContactsEndpoint {
    case getList
}

extension ContactsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getList:
            return "users"
        }
    }
}
