//
//  ReceiptViewModel.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 12/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class ReceiptViewModel {
    
    // MARK: - Constants
    
    private let model: TransactionReceipt
    
    // MARK: - Init
    
    init(_ model: TransactionReceipt) {
        self.model = model
    }
    
    // MARK: - Variables to view
    
    var contactImage: String? {
        return self.model.destUser?.image
    }
    
    var cardName: String {
        return "Mastercard \(lastDigitsCard ?? "")"
    }
    
    var lastDigitsCard: String?
    
    var contactName: String {
        return self.model.destUser?.name ?? ""
    }
    
    var value: String {
        return (self.model.value ?? 0.0).toCurrency()
    }
    
    private var date: Date {
        if let time = self.model.timestamp {
            return Date(timeIntervalSince1970: TimeInterval(time))
        }
    
        return Date()
    }
    
    var transactionDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy 'às' H':'mm"
        return formatter.string(from: self.date)
    }
    
    var transactionId: String {
        return "Transação: \(self.model.id ?? 0)"
    }
}
