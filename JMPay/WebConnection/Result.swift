//
//  Result.swift
//  JMPay
//
//  Created by 004_C02V35DEHV29 on 09/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

enum Result<T> {
    case success(T)
    case error(Error)
}

extension Result {
    func map<U>(_ block: (T) throws -> U) -> Result<U> {
        switch self {
        case .success(let object):
            do {
                let newObject = try block(object)
                return .success(newObject)
            } catch let error {
                return .error(error)
            }
            
        case .error(let error):
            return .error(error)
        }
    }
}
