//
//  TransactionViewModel.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class TransactionViewModel {
    
    private var model: Transaction
    private let api: TransactionAPI
    
    init(_ model: Transaction = Transaction(), api: TransactionAPI = TransactionAPI()) {
        self.model = model
        self.api = api
    }
    
    var contact: ContactViewModel? {
        didSet {
            self.contactId = contact?.id ?? 0
        }
    }
    
    private var contactId: Int? {
        get {
            return model.destUserId ?? 0
        }
        set {
            model.destUserId = newValue
        }
    }
    
    var value: String? {
        didSet {
            let numFormatter = NumberFormatter()
            numFormatter.locale = Locale.br
            self.doubleValue = Double(exactly: numFormatter.number(from: value ?? "") ?? 0.0) ?? 0.0
        }
    }
    
    private var doubleValue: Double? {
        get {
            return model.value ?? 0.0
        }
        set {
            model.value = newValue
        }
    }
    
    var cardNumber: String? {
        get {
            return "Mastercard \(model.cardNumber?.suffix(4) ?? "") • "
        }
        set {
            model.cardNumber = newValue?.onlyNumbers()
        }
    }
    
    var cardName: String?
    
    var cvv: String? {
        get {
            return model.cvv ?? ""
        }
        set {
            model.cvv = newValue
        }
    }
    
    var expiryDate: String? {
        get {
            return model.expiryDate ?? ""
        }
        set {
            model.expiryDate = newValue
        }
    }
    
    func doTransfer(value: String, completion: @escaping (_ receipt: ReceiptViewModel?, _ error: String?) -> Void) {
        self.value = value
        self.api.doTransfer(transaction: model) { result in
            switch result {
            case .success(let response):
                if let receipt = response.receipt, let status = receipt.success, status {
                    let viewModel = ReceiptViewModel(receipt)
                    viewModel.lastDigitsCard = "\(self.model.cardNumber?.suffix(4) ?? "")"
                    completion(viewModel, nil)
                    return
                }
                
                completion(nil, nil)
            case .error(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
}
