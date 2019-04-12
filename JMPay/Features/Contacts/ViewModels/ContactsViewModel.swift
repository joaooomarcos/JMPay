//
//  ContactsViewModel.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

class ContactsViewModel {
    
    // MARK: - Constants
    
    private let api: ContactsAPI
    
    // MARK: - Variables
    
    private var displayItems: [ContactViewModel]
    private var items: [ContactViewModel] {
        didSet {
            self.displayItems = items
        }
    }
    
    // MARK: - Init
    
    init(_ models: [ContactViewModel] = [], api: ContactsAPI = ContactsAPI()) {
        self.items = models
        self.displayItems = models
        self.api = api
    }
    
    // MARK: - Variables to view
    
    var numberOfElements: Int {
        return self.displayItems.count
    }
    
    func element(for index: Int) -> ContactViewModel {
        return self.displayItems[index]
    }
    
    // MARK: - Data stuffs
    
    func filter(text: String, completion: () -> Void) {
        if !text.isEmpty {
            self.displayItems = items.filter({( item: ContactViewModel) -> Bool in
                item.name.lowercased().contains(text.lowercased()) || item.username.lowercased().contains(text.lowercased())
            })
        } else {
            self.displayItems = items
        }
        completion()
    }
    
    // MARK: - WebConnection
    
    func load(completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        self.api.getContactList { result in
            switch result {
            case .success(let contacts):
                self.items = contacts.map({ ContactViewModel($0) })
                completion(true, nil)
            case .error(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
}
