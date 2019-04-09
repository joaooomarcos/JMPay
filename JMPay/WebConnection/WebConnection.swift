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
        
        let allParams = self.addDefaultParams(parameters)
        
        RequestManager().request(url: url, method: method.toAlamofire(), parameters: allParams, headers: headers, completion: completion)
    }
    
    static private func addDefaultParams(_ inParams: [String: Any]) -> [String: Any] {
        var params: [String: Any] = [:]
        
        params += inParams
        
        return params
    }
    
}
