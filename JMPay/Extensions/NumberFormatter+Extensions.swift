//
//  NumberFormatter+Extensions.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 12/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func custom() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.currencySymbol = "R$"
        formatter.locale = Locale.br
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        return formatter
    }
}
