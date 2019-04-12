//
//  Optional+Extensions.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 12/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isNullOrEmpty: Bool {
        return (self ?? "").isEmpty
    }
}
