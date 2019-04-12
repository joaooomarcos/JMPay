//
//  TransactionAPI.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class TransactionAPI {
    func doTransfer(transaction: Transaction, completion: @escaping (Result<TransactionResponse>) -> Void) {
        
        var parameters: [String: Any] = [:]
        
        do {
            let encoder = JSONEncoder()
            parameters = try encoder.encodeJSONObject(transaction) as? [String: Any] ?? [:]
        } catch {
            completion(.error(APIError.invalidData))
            return
        }
        
        WebConnection.request(endpoint: TransactionEndpoint.doTransfer, method: .post, parameters: parameters, completion: completion)
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
