//
//  TextFieldError.swift
//  JMPay
//
//  Created by Joao Marcos Ribeiro Araujo on 11/04/19.
//  Copyright © 2019 JM. All rights reserved.
//

import Foundation

enum TextFieldError: Error {
    case invalid(_ text: String)
    case empty
}

extension TextFieldError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalid(let text):
            return NSLocalizedString("\(text) inválido", comment: "Invalid field")
        case .empty:
            return NSLocalizedString("preencha o campo", comment: "Empty field")
        }
    }
}
