//
//  JSONDecoder+Extensions.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, fromDict dict: [AnyHashable: Any]) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return try self.decode(type, from: data)
    }
    
    func decode<T>(_ type: T.Type, fromArray array: [[AnyHashable: Any]]) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
        return try self.decode(type, from: data)
    }
}

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}
