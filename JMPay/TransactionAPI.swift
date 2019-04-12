//
//  TransactionAPI.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class TransactionAPI {
    func getContactList(completion: @escaping (Result<[Contact]>) -> Void) {
        WebConnection.request(endpoint: TransactionEndpoint.doTransfer, completion: completion)
    }
}

enum TransactionEndpoint {
    case doTransfer
}

extension TransactionEndpoint: Endpoint {
    var path: String {
        switch self {
        case .doTransfer:
            return "transaction"
        }
    }
}
