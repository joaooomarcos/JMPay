//
//  WebConnection.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum WebConnection {
    
    static func request<T: Decodable>(url: URL, method: HTTPMethod = .get, parameters: [String: Any] = [:], headers: HTTPHeaders = [:], completion: @escaping (_ result: Result<T>) -> Void) {
        
        RequestManager().request(url: url, method: method.toAlamofire(), parameters: parameters, headers: headers, completion: completion)
    }
}
