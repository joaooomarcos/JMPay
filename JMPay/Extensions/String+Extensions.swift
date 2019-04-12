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
    
    func lastDigitsForCard() -> String {
        return self.last(4)
    }
    
    func last(_ length: Int) -> String {
        return "\(self.suffix(length))"
    }
    
    func toDouble() -> Double {
        return Double(exactly: NumberFormatter.custom().number(from: self) ?? 0.0) ?? 0.0
    }
    
    func currencyInputFormatting() -> String {
        let formatter = NumberFormatter.custom()
        
        var amountWithPrefix = self
        
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            let options = NSRegularExpression.MatchingOptions(rawValue: 0)
            let range = NSRange(location: 0, length: self.count)
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: options, range: range, withTemplate: "")
        } catch {
            return "0,00"
        }
        
        let double = (amountWithPrefix as NSString).doubleValue
        let number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
            return "0,00"
        }
        
        return formatter.string(from: number) ?? "0,00"
    }
}
