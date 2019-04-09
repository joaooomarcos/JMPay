//
//  Endpoint.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
    var url: URL { get }
}

extension Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var url: URL {
        if var urlBase = URL(string: self.base) {
            urlBase.appendPathComponent(self.path)
            return urlBase
        }
        
        fatalError()
    }
}
