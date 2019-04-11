//
//  String+Extensions.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

extension String {
    func onlyNumbers() -> String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
