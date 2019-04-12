//
//  Double+Extensions.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 12/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

extension Double {
    func toCurrency() -> String {
        let number = NSNumber(floatLiteral: self)
        return "R$ " + (NumberFormatter.custom().string(from: number) ?? "0,00")
    }
}
